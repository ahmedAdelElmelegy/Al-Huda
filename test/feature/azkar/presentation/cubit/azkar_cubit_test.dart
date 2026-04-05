import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/error/result.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/feature/azkar/domain/entities/azkar_category_entity.dart';
import 'package:al_huda/feature/azkar/domain/repositories/azkar_repository.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAzkarRepository extends Mock implements AzkarRepository {}

class MockAzkarServices extends Mock implements AzkarServices {}

void main() {
  late AzkarCubit cubit;
  late MockAzkarRepository mockAzkarRepository;
  late MockAzkarServices mockAzkarServices;

  setUp(() {
    mockAzkarRepository = MockAzkarRepository();
    mockAzkarServices = MockAzkarServices();
    cubit = AzkarCubit(mockAzkarRepository, mockAzkarServices);
  });

  tearDown(() {
    cubit.close();
  });

  group('loadAzkar', () {
    final tCategorList = [
      const AzkarCategoryEntity(
        id: 1,
        name: 'Morning',
        audio: '',
        filename: '',
        azkar: [],
      )
    ];

    test('initial state should be AzkarInitial', () {
      expect(cubit.state, isA<AzkarInitial>());
    });

    blocTest<AzkarCubit, AzkarState>(
      'emits [AzkarLoading, AzkarLoaded] when data is gotten successfully',
      build: () {
        when(() => mockAzkarRepository.getAzkarCategories())
            .thenAnswer((_) async => Success(tCategorList));
        return cubit;
      },
      act: (cubit) => cubit.loadAzkar(),
      expect: () => [
        isA<AzkarLoading>(),
        isA<AzkarLoaded>(),
      ],
      verify: (_) {
        verify(() => mockAzkarRepository.getAzkarCategories()).called(1);
        expect(cubit.azkarCategories, equals(tCategorList));
      },
    );

    blocTest<AzkarCubit, AzkarState>(
      'emits [AzkarLoading, AzkarError] when getting data fails',
      build: () {
        when(() => mockAzkarRepository.getAzkarCategories())
            .thenAnswer((_) async => const Error(CacheFailure('Failed to load')));
        return cubit;
      },
      act: (cubit) => cubit.loadAzkar(),
      expect: () => [
        isA<AzkarLoading>(),
        isA<AzkarError>(),
      ],
      verify: (cubit) {
        verify(() => mockAzkarRepository.getAzkarCategories()).called(1);
      },
    );
  });
}
