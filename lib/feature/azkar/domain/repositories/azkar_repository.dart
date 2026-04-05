import 'package:al_huda/core/error/result.dart';
import 'package:al_huda/feature/azkar/domain/entities/azkar_category_entity.dart';

abstract class AzkarRepository {
  Future<Result<List<AzkarCategoryEntity>>> getAzkarCategories();
}
