# Quickstart: Clean Architecture Refactoring

**Branch**: `001-clean-arch-foundation` | **Date**: 2026-04-05

This guide provides the necessary steps for developers to refactor an existing feature module into the new Clean Architecture layout or to build a new feature from scratch.

## 1. Feature Structure Outline

For any feature `XYZ` (e.g., `azkar`), your folder structure within `lib/feature/xyz/` should be:

```text
xyz/
├── data/
│   ├── data_sources/
│   │   ├── xyz_remote_data_source.dart  (optional)
│   │   └── xyz_local_data_source.dart   (optional)
│   ├── model/
│   │   └── xyz_dto.dart                 (with toEntity() method)
│   └── repo/
│       └── xyz_repo_impl.dart           (implements XyzRepository)
├── domain/
│   ├── entities/
│   │   └── xyz_entity.dart              (immutable, Equatable, pure Dart)
│   └── repositories/
│       └── xyz_repository.dart          (abstract interface)
└── presentation/
    ├── manager/cubit/
    │   ├── xyz_cubit.dart               (depends on XyzRepository)
    │   └── xyz_state.dart               (Loading, Error, Loaded states)
    ├── screens/
    └── widgets/
```

## 2. Refactoring a Pilot Feature (Example: Azkar)

### Step 2.1: Domain Layer
1. **Create Entity**: Define `AzkarCategoryEntity` and `ZikrEntity` in `domain/entities/`. Make sure they extend `Equatable` and have no dependencies on Hive or JSON.
2. **Create Abstract Repository**: Define `AzkarRepository` in `domain/repositories/` returning `Future<Either<Failure, List<AzkarCategoryEntity>>>`. (Use the `Result` or `Either` type to explicitly represent success/failure).

### Step 2.2: Data Layer
1. **Prepare DTOs**: Update the existing `Zikr` and `AzkarCategory` classes in `data/model/` with a `.toEntity()` mapper function. Keep `@HiveType` here.
2. **Setup Data Sources**: Create `data/data_sources/azkar_local_data_source.dart`. Move the JSON reading logic from the old repo here.
3. **Implement Repository**: Rename the old repo to `AzkarRepoImpl`. Have it implement `AzkarRepository`. Inject the local data source into it. It should catch exceptions and return `Error(CacheFailure(...))` or `Success(entities)`.

### Step 2.3: Dependency Injection
1. Update `core/di/injection.dart`.
2. Register the data source: `getIt.registerLazySingleton(() => AzkarLocalDataSource());`
3. Register the repository using its interface: `getIt.registerLazySingleton<AzkarRepository>(() => AzkarRepoImpl(getIt()));`
4. Register the cubit: `getIt.registerFactory(() => AzkarCubit(getIt<AzkarRepository>()));`

### Step 2.4: Presentation Layer
1. Edit `AzkarCubit` to accept `AzkarRepository` in its constructor, not the concrete implementation.
2. Update the `loadAzkar` method to handle the `Result<T>` object efficiently, replacing any inline try/catch with fold logic:

```dart
Future<void> fetchAzkar() async {
  emit(AzkarLoading());
  final result = await repo.loadAzkar();
  switch (result) {
    case Success(data: final azkar):
      emit(AzkarLoaded(azkar));
      break;
    case Error(failure: final failure):
      emit(AzkarError(failure.errMessage));
      break;
  }
}
```

## 3. Creating `Result` and Enhancing `Failure`

Before the pilot refactors, update `lib/core/error/`:
1. Modify `failure.dart` so `Failure` extends `Equatable`. Add `CacheFailure` and `ParsingFailure`.
2. Create `result.dart` defining the `Result<T>` sealed class with `Success` and `Error`.

## 4. Run Tests

For each pilot feature, write unit tests in `test/feature/xyz/`:
- `data/repo/xyz_repo_impl_test.dart` (Using `MockXyzLocalDataSource` and `MockXyzRemoteDataSource`)
- `presentation/cubit/xyz_cubit_test.dart` (Using `MockXyzRepository`)
