import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/error/result.dart';
import 'package:al_huda/feature/azkar/data/data_sources/azkar_local_data_source.dart';
import 'package:al_huda/feature/azkar/data/model/azkar_category.dart';
import 'package:al_huda/feature/azkar/data/repo/azkar_repo_impl.dart';
import 'package:al_huda/feature/azkar/domain/entities/azkar_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAzkarLocalDataSource extends Mock implements AzkarLocalDataSource {}

void main() {
  late AzkarRepoImpl repository;
  late MockAzkarLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockAzkarLocalDataSource();
    repository = AzkarRepoImpl(mockLocalDataSource);
  });

  group('getAzkarCategories', () {
    final tAzkarCategoryModel = AzkarCategory(
      id: 1,
      name: 'Morning',
      audio: 'audio.mp3',
      filename: 'morning.json',
      azkar: [],
    );
    final tAzkarCategoryModelList = [tAzkarCategoryModel];

    test('should return local data when local data source succeeds', () async {
      // arrange
      when(() => mockLocalDataSource.loadAzkar())
          .thenAnswer((_) async => tAzkarCategoryModelList);
      // act
      final result = await repository.getAzkarCategories();
      // assert
      expect(result, isA<Success<List<AzkarCategoryEntity>>>());
      if (result is Success<List<AzkarCategoryEntity>>) {
        expect(result.data.first.id, 1);
        expect(result.data.first.name, 'Morning');
      }
      verify(() => mockLocalDataSource.loadAzkar()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when local data source fails', () async {
      // arrange
      when(() => mockLocalDataSource.loadAzkar())
          .thenThrow(Exception('Fail'));
      // act
      final result = await repository.getAzkarCategories();
      // assert
      expect(result, isA<Error<List<AzkarCategoryEntity>>>());
      if (result is Error<List<AzkarCategoryEntity>>) {
        expect(result.failure, const CacheFailure('Failed to load local Azkar data'));
      }
      verify(() => mockLocalDataSource.loadAzkar()).called(1);
    });
  });
}
