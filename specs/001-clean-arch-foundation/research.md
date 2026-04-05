# Research: Clean Architecture Foundation

**Branch**: `001-clean-arch-foundation` | **Date**: 2026-04-05

## R1: Repository Pattern with Abstract Interfaces in Flutter

**Decision**: Use abstract classes (not `interface` keyword) as repository contracts in the domain layer, with concrete implementations in the data layer registered via GetIt.

**Rationale**: Abstract classes in Dart serve the same role as interfaces and are widely supported by the testing ecosystem (mocktail/mockito). GetIt's `registerLazySingleton<AbstractType>(() => ConcreteImpl())` pattern makes this seamless.

**Pattern**:
```dart
// domain/repositories/azkar_repository.dart
abstract class AzkarRepository {
  Future<Either<Failure, List<AzkarCategoryEntity>>> loadAzkar();
}

// data/repo/azkar_repo_impl.dart
class AzkarRepoImpl implements AzkarRepository {
  final AzkarLocalDataSource localDataSource;
  // ...
}

// di/injection.dart
getIt.registerLazySingleton<AzkarRepository>(() => AzkarRepoImpl(...));
```

**Alternatives considered**:
- Dart 3 `interface class`: Valid but adds keyword noise without functional benefit for this project size.
- No abstraction (current state): Prevents mocking in tests; rejected.

---

## R2: Either Type for Error Handling (dartz vs fpdart vs manual)

**Decision**: Use a lightweight custom `Either<L, R>` or the `dartz` package for functional error handling in repositories, returning `Either<Failure, Data>` instead of throwing exceptions.

**Rationale**: The current repos use try/catch with rethrow, which forces cubits to also wrap in try/catch. The `Either` pattern makes error handling explicit at the type level, ensuring cubits always handle both success and failure paths.

**Pattern**:
```dart
// Repository returns Either
Future<Either<Failure, List<SurahEntity>>> fetchSurahs();

// Cubit consumes it
final result = await repository.fetchSurahs();
result.fold(
  (failure) => emit(QranError(failure.errMessage)),
  (surahs) => emit(QranLoaded(surahs)),
);
```

**Alternatives considered**:
- `dartz` package: Popular but large; only `Either` is needed.
- `fpdart`: More modern but adds unnecessary FP concepts.
- Custom sealed class `Result<T>`: Lightest option, recommended. No external dependency.

**Final recommendation**: Custom `Result<T>` sealed class (Dart 3 sealed classes are ideal):
```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}
```

---

## R3: Data Source Separation (Local vs Remote)

**Decision**: Introduce explicit `LocalDataSource` and `RemoteDataSource` classes per feature where applicable. Repository implementations orchestrate between them.

**Rationale**: Current repos mix data fetching and caching logic. Separating sources enables independent testing and makes the caching strategy (TTL per data type) implementable.

**Pattern (API-driven feature like Quran)**:
```dart
class QranRepoImpl implements QranRepository {
  final QranRemoteDataSource remote;
  final QranLocalDataSource local;

  Future<Result<List<SurahEntity>>> fetchSurahs() async {
    try {
      // Try remote first (dynamic content)
      final remoteData = await remote.fetchSurahs();
      await local.cacheSurahs(remoteData);
      return Success(remoteData.map((dto) => dto.toEntity()).toList());
    } on DioException catch (e) {
      // Fallback to cache
      final cached = await local.getCachedSurahs();
      if (cached != null) return Success(cached.map((dto) => dto.toEntity()).toList());
      return Error(ServerFailure.fromDioError(e));
    }
  }
}
```

**Pattern (local-only feature like Azkar)**:
```dart
class AzkarRepoImpl implements AzkarRepository {
  final AzkarLocalDataSource localDataSource;

  Future<Result<List<AzkarCategoryEntity>>> loadAzkar() async {
    try {
      final data = await localDataSource.loadFromAssets();
      return Success(data.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Error(CacheFailure('Failed to load Azkar data'));
    }
  }
}
```

---

## R4: Failure Model Enhancement

**Decision**: Extend the existing `Failure` hierarchy with `CacheFailure` and `ParsingFailure` subtypes, and make `Failure` extend `Equatable` for testability.

**Rationale**: Current `failure.dart` only has `ServerFailure`. The caching strategy needs `CacheFailure` for storage errors, and `ParsingFailure` for corrupt data handling.

**Enhanced model**:
```dart
abstract class Failure extends Equatable {
  final String errMessage;
  const Failure(this.errMessage);
  
  @override
  List<Object> get props => [errMessage];
}

class ServerFailure extends Failure { ... }  // Existing (add Equatable)
class CacheFailure extends Failure { ... }   // NEW
class ParsingFailure extends Failure { ... } // NEW
```

---

## R5: Cache Strategy Implementation with Hive

**Decision**: Use Hive boxes per feature for local caching. Static data (Azkar) is read from bundled JSON assets and cached in Hive on first load. Dynamic data (Prayer Times) is cached with a timestamp and refreshed when the stored date differs from today.

**Rationale**: Hive is already integrated (hive_ce). Per-feature boxes provide isolation and make cache clearing per-feature possible.

**Cache TTL strategy**:
| Data Type | Cache Policy | Refresh Trigger |
|-----------|-------------|-----------------|
| Azkar (static) | Indefinite | Never (bundled asset) |
| Quran Surahs (static) | Indefinite | Only on app update |
| Quran Ayat (semi-static) | Indefinite after first load | Manual refresh only |
| Prayer Times (daily) | 24 hours | Date change or location change |
| Radio Streams (real-time) | No caching | Always fetch fresh |

---

## R6: Testing Strategy with Mocktail

**Decision**: Use `mocktail` (not `mockito`) for creating mock implementations of abstract repositories and data sources.

**Rationale**: `mocktail` requires no code generation (unlike `mockito` with `@GenerateMocks`), making it simpler for this project. Works seamlessly with abstract classes.

**Pattern**:
```dart
class MockAzkarRepository extends Mock implements AzkarRepository {}

void main() {
  late AzkarCubit cubit;
  late MockAzkarRepository mockRepo;

  setUp(() {
    mockRepo = MockAzkarRepository();
    cubit = AzkarCubit(mockRepo);
  });

  test('emits loaded state when loadAzkar succeeds', () {
    when(() => mockRepo.loadAzkar())
        .thenAnswer((_) async => Success([/* test data */]));
    // ...
  });
}
```

**Alternatives considered**:
- `mockito` with code generation: Works but adds build_runner dependency for tests.
- Manual mocks: Too verbose for 3 features × 2-3 classes each.

---

## R7: Domain Entity Mapping Strategy

**Decision**: DTOs (data layer) have `toEntity()` methods that convert to pure domain entities. Domain entities have no framework dependencies (no Hive annotations, no JSON serialization).

**Rationale**: This keeps the domain layer pure and ensures the Presentation layer never depends on data-layer serialization details.

**Pattern**:
```dart
// data/model/azkar_category.dart (DTO - keeps Hive/JSON annotations)
class AzkarCategoryDTO {
  // ... Hive fields, fromJson
  AzkarCategoryEntity toEntity() => AzkarCategoryEntity(
    name: name,
    azkar: azkar.map((z) => z.toEntity()).toList(),
  );
}

// domain/entities/azkar_category_entity.dart (pure)
class AzkarCategoryEntity extends Equatable {
  final String name;
  final List<ZikrEntity> azkar;
  // ... const constructor, props
}
```
