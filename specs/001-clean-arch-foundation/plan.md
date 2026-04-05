# Implementation Plan: Clean Architecture Foundation

**Branch**: `001-clean-arch-foundation` | **Date**: 2026-04-05 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-clean-arch-foundation/spec.md`

## Summary

Refactor the Al-Huda Islamic companion app to follow Clean Architecture with Feature-First MVVM. This iteration establishes the core architecture layers (Presentation → Domain → Data), introduces abstract repository interfaces for testability, enhances the failure model, and refactors 3 pilot features (Azkar, Quran, Prayer Times) as reference implementations. BLoC/Cubit remains the state management solution. GetIt for DI, Hive for local caching, and Dio for networking are retained.

## Technical Context

**Language/Version**: Dart 3.8.1 / Flutter (latest stable)  
**Primary Dependencies**: flutter_bloc 9.1.1, get_it 8.2.0, dio 5.9.0, hive_ce 2.11.3, equatable 2.0.8, easy_localization 3.0.8  
**Storage**: Hive (hive_ce) for local cache, SharedPreferences for user preferences  
**Testing**: flutter_test (built-in), mocktail or mockito for mocking  
**Target Platform**: Android & iOS mobile  
**Project Type**: Mobile app (Flutter)  
**Performance Goals**: 60fps scrolling, <2s screen load, offline-capable  
**Constraints**: Offline-first for static content, RTL primary layout, BLoC/Cubit only (no Riverpod)  
**Scale/Scope**: 22 features total, 3 pilot refactors this iteration (Azkar, Quran, Prayer Times)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

Constitution is not yet configured (template-only). No gates to enforce. Proceeding with best-practice defaults:

- ✅ **Separation of Concerns**: Enforced by 3-layer architecture
- ✅ **Testability**: Abstract repo interfaces + DI enable mocking
- ✅ **Simplicity**: No use case layer (pragmatic decision); abstract repos are the minimum needed for testability
- ✅ **Incremental approach**: 3 pilot features, not full rewrite

## Project Structure

### Documentation (this feature)

```text
specs/001-clean-arch-foundation/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (internal interfaces)
└── tasks.md             # Phase 2 output (created by /speckit.tasks)
```

### Source Code (repository root)

```text
lib/
├── main.dart
├── app.dart
├── bloc.dart                          # MultiBlocProvider (refactor to lazy per-feature)
│
├── core/
│   ├── data/
│   │   ├── api_url/                   # API endpoint constants
│   │   ├── exeptions/                 # → rename to exceptions/
│   │   ├── models/                    # Shared data models
│   │   └── response/                  # API response wrappers
│   ├── di/
│   │   └── injection.dart             # GetIt registration (refactor to use abstractions)
│   ├── error/
│   │   └── failure.dart               # Failure model (enhance with CacheFailure, ParsingFailure)
│   ├── services/                      # Shared services (API, location, notifications)
│   ├── theme/
│   │   ├── app_theme.dart             # Light/dark ThemeData (already complete)
│   │   ├── colors.dart                # ColorManager
│   │   └── style.dart                 # Text styles
│   ├── utils/                         # Utilities
│   └── widgets/                       # Shared reusable widgets (add StateWidget)
│
├── feature/
│   ├── azkar/                         # PILOT 1: Local-only pattern
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   └── azkar_local_data_source.dart    # [NEW] JSON asset loader
│   │   │   ├── model/
│   │   │   │   ├── azkar_category.dart              # Existing DTO
│   │   │   │   └── zikr.dart                        # Existing DTO (Hive)
│   │   │   └── repo/
│   │   │       └── azkar_repo_impl.dart             # [RENAME] Concrete impl
│   │   ├── domain/                                   # [NEW]
│   │   │   ├── entities/
│   │   │   │   ├── azkar_category_entity.dart       # [NEW] Pure domain entity
│   │   │   │   └── zikr_entity.dart                 # [NEW] Pure domain entity
│   │   │   └── repositories/
│   │   │       └── azkar_repository.dart             # [NEW] Abstract interface
│   │   └── presentation/
│   │       ├── manager/cubit/                        # Existing cubit (update to use interface)
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── qran/                          # PILOT 2: API + caching pattern
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   ├── qran_remote_data_source.dart     # [NEW] API calls via Dio
│   │   │   │   └── qran_local_data_source.dart      # [NEW] Hive caching
│   │   │   ├── model/                               # Existing DTOs
│   │   │   └── Repo/
│   │   │       ├── qran_repo_impl.dart              # [RENAME] With cache strategy
│   │   │       └── ayat_repo_impl.dart              # [RENAME] With cache strategy
│   │   ├── domain/                                   # [NEW]
│   │   │   ├── entities/
│   │   │   │   ├── surah_entity.dart                # [NEW]
│   │   │   │   └── ayat_entity.dart                 # [NEW]
│   │   │   └── repositories/
│   │   │       ├── qran_repository.dart              # [NEW] Abstract interface
│   │   │       └── ayat_repository.dart              # [NEW] Abstract interface
│   │   └── presentation/                            # Existing (update cubit deps)
│   │
│   ├── prayer_time/                   # PILOT 3: Computed + API + notification pattern
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   ├── prayer_remote_data_source.dart   # [NEW] Aladhan API
│   │   │   │   └── prayer_local_data_source.dart    # [NEW] Hive cache
│   │   │   ├── model/                               # Existing DTOs
│   │   │   └── repo/
│   │   │       └── prayer_repo_impl.dart            # [RENAME] With daily refresh
│   │   ├── domain/                                   # [NEW]
│   │   │   ├── entities/
│   │   │   │   └── prayer_time_entity.dart          # [NEW]
│   │   │   └── repositories/
│   │   │       └── prayer_repository.dart            # [NEW] Abstract interface
│   │   └── presentation/                            # Existing (update cubit deps)
│   │
│   └── [19 other features]/           # Unchanged this iteration
│
test/
├── core/
│   └── error/
│       └── failure_test.dart                        # [NEW]
├── feature/
│   ├── azkar/
│   │   ├── data/repo/azkar_repo_impl_test.dart      # [NEW]
│   │   └── presentation/cubit/azkar_cubit_test.dart  # [NEW]
│   ├── qran/
│   │   ├── data/repo/qran_repo_impl_test.dart       # [NEW]
│   │   └── presentation/cubit/qran_cubit_test.dart   # [NEW]
│   └── prayer_time/
│       ├── data/repo/prayer_repo_impl_test.dart      # [NEW]
│       └── presentation/cubit/prayer_time_cubit_test.dart # [NEW]
└── widget_test.dart                                  # Existing (minimal)
```

**Structure Decision**: Feature-first with Clean Architecture sub-layers. Each pilot feature gets a new `domain/` layer with abstract interfaces and pure entities. The `data/` layer adds explicit data sources (local/remote). Existing `presentation/` cubits are updated to depend on abstractions. Non-pilot features remain unchanged.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|--------------------------------------|
| Abstract repository interfaces | Enable mocking for unit tests; allow swapping data sources without changing cubits | Direct concrete class usage prevents isolated testing and violates dependency inversion |
| Separate data sources (local/remote) | Required for offline-first caching strategy with TTL per data type | Single-source repos cannot implement cache-then-network or offline fallback patterns |
