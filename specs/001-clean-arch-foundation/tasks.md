---
description: "Executable task list for Clean Architecture Foundation"
---

# Tasks: Clean Architecture Foundation

**Input**: Design documents from `/specs/001-clean-arch-foundation/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Test tasks are included as requested by FR-013 and FR-014 (User Story 5).

**Organization**: Tasks are grouped by the pilot features required to fulfill the user stories.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Core tools dependency injection and directory structure setup

- [x] T001 Open `pubspec.yaml` and verify `mocktail` is added to dev_dependencies (run `flutter pub add --dev mocktail` if needed)
- [x] T002 Create empty `test/core/error/` and `test/feature/` structural directories

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Required error and return type foundations for all pilot features (Supports US4)

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 Implement `Result<T>` sealed class in `lib/core/error/result.dart`
- [x] T004 Enhance `Failure` class in `lib/core/error/failure.dart` to extend Equatable
- [x] T005 [P] Add `CacheFailure` error class to `lib/core/error/failure.dart`
- [x] T006 [P] Add `ParsingFailure` error class to `lib/core/error/failure.dart`
- [x] T007 Write unit tests for Failure and Result in `test/core/error/failure_test.dart`

**Checkpoint**: Core error handling foundations are ready.

---

## Phase 3: User Stories 1 & 2 - Azkar Pilot Refactor (Priority: P1) 🎯 MVP

**Goal**: Refactor the Azkar feature to fully utilize Clean Architecture, ensuring fast loads (US1) and local-only caching functionality (US2).

**Independent Test**: Azkar screen loads correctly, and unit tests for `AzkarRepoImpl` and `AzkarCubit` pass.

### Tests for Azkar (US5) ⚠️

- [x] T008 [P] [US5] Create Mock classes in `test/feature/azkar/data/repo/azkar_repo_impl_test.dart`
- [x] T009 [P] [US5] Create Mock classes in `test/feature/azkar/presentation/cubit/azkar_cubit_test.dart`

### Implementation for Azkar (US1, US2)

- [x] T010 [P] [US2] Create pure `AzkarCategoryEntity` and `ZikrEntity` in `lib/feature/azkar/domain/entities/`
- [x] T011 [P] [US2] Create abstract `AzkarRepository` in `lib/feature/azkar/domain/repositories/azkar_repository.dart`
- [x] T012 [US2] Update `AzkarCategory` and `Zikr` DTOs in `lib/feature/azkar/data/model/` with `toEntity()` mappers
- [x] T013 [US2] Create local data source `AzkarLocalDataSource` in `lib/feature/azkar/data/data_sources/azkar_local_data_source.dart` to load JSON assets
- [x] T014 [US2] Rename and implement `AzkarRepoImpl` in `lib/feature/azkar/data/repo/azkar_repo_impl.dart` to use new data source and return `Result<T>`
- [x] T015 [US1] Update `lib/core/di/injection.dart` to register `AzkarLocalDataSource` and `AzkarRepository` (via `AzkarRepoImpl`)
- [x] T016 [US1] Refactor `AzkarCubit` in `lib/feature/azkar/presentation/manager/cubit/` to depend on `AzkarRepository` and handle `Result<T>`
- [x] T017 [US5] Implement unit tests in `test/feature/azkar/data/repo/azkar_repo_impl_test.dart`
- [x] T018 [US5] Implement unit tests in `test/feature/azkar/presentation/cubit/azkar_cubit_test.dart`

**Checkpoint**: At this point, the Azkar feature uses Clean Architecture independently.

---

## Phase 4: User Stories 1 & 2 - Quran Pilot Refactor (Priority: P1)

**Goal**: Refactor the Quran feature to use remote API + local Hive caching, satisfying online/offline transitions (US2).

**Independent Test**: Quran screen can fetch surahs from network and fall back to local cache when offline.

### Tests for Quran (US5) ⚠️

- [ ] T019 [P] [US5] Create setup for tests in `test/feature/qran/data/repo/qran_repo_impl_test.dart`
- [ ] T020 [P] [US5] Create setup for tests in `test/feature/qran/presentation/cubit/qran_cubit_test.dart`

### Implementation for Quran (US1, US2)

- [ ] T021 [P] [US2] Create pure `SurahEntity` and `AyatEntity` in `lib/feature/qran/domain/entities/`
- [ ] T022 [P] [US2] Create abstract `QranRepository` and `AyatRepository` in `lib/feature/qran/domain/repositories/`
- [ ] T023 [US2] Update existing `lib/feature/qran/data/model/` DTOs with `toEntity()` mappers
- [ ] T024 [P] [US2] Create `QranRemoteDataSource` in `lib/feature/qran/data/data_sources/qran_remote_data_source.dart` handling Dio network calls
- [ ] T025 [P] [US2] Create `QranLocalDataSource` in `lib/feature/qran/data/data_sources/qran_local_data_source.dart` handling Hive caching
- [ ] T026 [US2] Implement `QranRepoImpl` and `AyatRepoImpl` in `lib/feature/qran/data/Repo/` orchestrating Cache-then-Network strategy returning `Result<T>`
- [ ] T027 [US1] Update `lib/core/di/injection.dart` for Quran repositories and data sources
- [ ] T028 [US1] Refactor `QranCubit` to depend on `QranRepository` abstractions and handle `Result<T>`
- [ ] T029 [US5] Implement unit tests for Quran repos and cubits

**Checkpoint**: The Quran feature is fully offline-capable following the new architecture.

---

## Phase 5: User Stories 1 & 2 - Prayer Times Refactor (Priority: P1)

**Goal**: Refactor Prayer Times to use the daily TTL caching strategy + API.

**Independent Test**: Prayer times are fetched from API and locally cached for 24 hours.

### Tests for Prayer Time (US5) ⚠️

- [ ] T030 [P] [US5] Setup prayer tests in `test/feature/prayer_time/data/repo/prayer_repo_impl_test.dart`

### Implementation for Prayer Time (US1, US2)

- [ ] T031 [P] [US2] Create `PrayerTimeEntity` in `lib/feature/prayer_time/domain/entities/prayer_time_entity.dart`
- [ ] T032 [P] [US2] Create `PrayerRepository` interface in `lib/feature/prayer_time/domain/repositories/`
- [ ] T033 [US2] Setup `PrayerRemoteDataSource` and `PrayerLocalDataSource` in `lib/feature/prayer_time/data/data_sources/`
- [ ] T034 [US2] Refactor `PrayerRepoImpl` to implement TTL-based 24h refresh logic and return `Result<PrayerTimeEntity>`
- [ ] T035 [US1] Update `injection.dart` for Prayer Times feature
- [ ] T036 [US1] Update Prayer Time Cubit to handle new architecture
- [ ] T037 [US5] Implement unit tests for prayer time cache logic

**Checkpoint**: All 3 pilot features are complete.

---

## Phase 6: User Story 4 - Consistent Error Handling (Priority: P2)

**Goal**: Graceful error handling in the UI so users see localized messages (from `Failure.errMessage`) instead of crashes.

- [ ] T038 [US4] Update Base or Common UI state widgets to cleanly handle `CacheFailure` and `ServerFailure` messages
- [ ] T039 [US4] Refactor `lib/core/data/exeptions/api_error_handeler.dart` to return mapped `Failure` objects if necessary

---

## Phase 7: Polish & Cross-Cutting

**Purpose**: Improvements that affect the application as a whole

- [ ] T040 Delete unused repository models and deprecated helper code
- [ ] T041 Code cleanup and dart format
- [ ] T042 Run `flutter test` to verify 100% pass rate
- [ ] T043 Validate Quickstart.md instructions match the finalized structure

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Can run immediately
- **Foundational (Phase 2)**: **BLOCKS** all feature refactoring (Phases 3-5)
- **User Stories (Phase 3+)**: Can be run in parallel once Foundation is complete

### Task Generation Summary

Total Tasks: 43
- Setup/Foundation: 7
- Azkar Refactor: 11
- Quran Refactor: 11
- Prayer Time Refactor: 8
- UI/Polish: 6

All tasks have been strictly formatted according to the checklist specification.
