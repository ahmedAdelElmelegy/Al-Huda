import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/error/result.dart';
import 'package:al_huda/feature/azkar/data/data_sources/azkar_local_data_source.dart';
import 'package:al_huda/feature/azkar/domain/entities/azkar_category_entity.dart';
import 'package:al_huda/feature/azkar/domain/repositories/azkar_repository.dart';

class AzkarRepoImpl implements AzkarRepository {
  final AzkarLocalDataSource localDataSource;

  AzkarRepoImpl(this.localDataSource);

  @override
  Future<Result<List<AzkarCategoryEntity>>> getAzkarCategories() async {
    try {
      final models = await localDataSource.loadAzkar();
      final entities = models.map((model) => model.toEntity()).toList();
      return Success(entities);
    } catch (e) {
      return const Error(CacheFailure('Failed to load local Azkar data'));
    }
  }
}
