# Feature Specification: Clean Architecture Foundation

**Feature Branch**: `001-clean-arch-foundation`  
**Created**: 2026-04-05  
**Status**: Draft  
**Input**: User description: "Build scalable, high-performance, and maintainable Flutter code following production best practices — Clean Architecture (Presentation, Domain, Data layers), MVVM pattern with Riverpod for state management, strict separation of concerns, performance optimization, SOLID principles, repository pattern, comprehensive testing, and responsive UI with dark/light mode support."

## Clarifications

### Session 2026-04-05

- Q: Should the project migrate to Riverpod, keep BLoC/Cubit, or use a hybrid approach given that 18+ cubits already exist? → A: Keep BLoC/Cubit as the sole state management solution; refactor for Clean Architecture layers only.
- Q: Should the Clean Architecture refactoring apply to all 22 existing features now, or be scoped incrementally? → A: Foundation + 2-3 pilot features as proof of concept; remaining features follow incrementally.
- Q: What cache invalidation policy should be used for offline data? → A: TTL per data type — static content (Quran, Azkar) cached indefinitely; dynamic content (prayer times, radio) refreshed on each access or daily.
- Q: Which features should be the 2-3 pilot refactors? → A: Azkar (local-only), Quran (API + caching + audio), and Prayer Times (computed + API + notifications).
- Q: Should the domain layer include use case classes, or should cubits call repositories directly? → A: Abstract repository interfaces only (for testability); cubits call repos directly without a use case layer.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Browse and Navigate App Features (Priority: P1)

A user opens the Al-Huda Islamic companion app and is presented with a home screen that loads quickly and displays all available features (Quran, Prayer Times, Azkar, Calendar, Tasbeh, Radio, etc.) in an organized, visually appealing layout. The user can tap on any feature card to navigate to the corresponding section without lag or UI jank.

**Why this priority**: The home screen is the first touchpoint for every user. If it loads slowly, stutters, or has navigation issues, users will abandon the app immediately. A well-architected foundation ensures every feature module loads independently and performantly.

**Independent Test**: Can be fully tested by launching the app, verifying the home screen renders within acceptable time, and navigating to each feature section. Delivers immediate value by proving the architectural layers are properly connected.

**Acceptance Scenarios**:

1. **Given** the app is freshly launched, **When** the home screen loads, **Then** all feature cards are displayed within 2 seconds and the UI is responsive to touch immediately.
2. **Given** the user is on the home screen, **When** they tap a feature card (e.g., Quran, Prayer Times), **Then** the corresponding screen opens within 1 second with a smooth transition.
3. **Given** the app is running on a low-end device, **When** the user scrolls through the home screen, **Then** the scroll is smooth at 60fps with no visible jank.

---

### User Story 2 - Access Data Offline and Online (Priority: P1)

A user with intermittent internet connectivity opens any data-driven feature (e.g., Azkar, Quran, Hadith). The app fetches data from the network when available and serves cached data when offline, without showing error screens or crashes. The transition between online and offline modes is seamless.

**Why this priority**: The target audience frequently uses the app in areas with poor connectivity (mosques, travel, rural areas). Reliable offline access is a core differentiator. The repository pattern with caching is fundamental to this experience.

**Independent Test**: Can be fully tested by loading a data-driven feature with internet, then disabling connectivity and verifying the same content remains accessible. Delivers value by ensuring users are never blocked from accessing religious content.

**Acceptance Scenarios**:

1. **Given** the user has internet connectivity, **When** they open a data-driven feature, **Then** fresh data is fetched from the server and displayed, and a local cache is updated.
2. **Given** the user has no internet connectivity, **When** they open a previously visited feature, **Then** cached data is displayed with a subtle offline indicator.
3. **Given** the user is offline and opens a feature for the first time (no cache), **When** the data cannot be loaded, **Then** a user-friendly empty state message is shown with a retry option.
4. **Given** the user transitions from offline to online, **When** they are on a cached screen, **Then** the app silently refreshes the data without disrupting the user's current view.

---

### User Story 3 - Switch Between Dark and Light Themes (Priority: P2)

A user navigates to the Settings screen and toggles between dark mode and light mode. The entire app immediately reflects the chosen theme across all screens, including custom components, text, icons, and background colors. The preference is persisted across app restarts.

**Why this priority**: Dark mode is essential for users who read Quran or Azkar at night. Theme consistency across the entire app depends on having a well-structured theming system at the foundation level.

**Independent Test**: Can be fully tested by toggling the theme switch and navigating across multiple screens to verify consistent styling. Delivers value by improving readability and reducing eye strain.

**Acceptance Scenarios**:

1. **Given** the user is in light mode, **When** they toggle to dark mode in settings, **Then** all visible screens, components, and text update to the dark theme instantly without a full app restart.
2. **Given** the user selected dark mode, **When** they close and reopen the app, **Then** the app launches in dark mode.
3. **Given** the app is in dark mode, **When** the user navigates to any feature (Quran, Azkar, Calendar, etc.), **Then** the feature screen renders with the correct dark theme colors and contrast ratios.

---

### User Story 4 - Experience Consistent Error Handling (Priority: P2)

A user encounters a network error, API failure, or unexpected data issue while using any feature. Instead of seeing a crash, a technical error message, or a blank screen, the user sees a friendly, localized error message with clear guidance on what to do next (retry, go back, check connectivity).

**Why this priority**: Graceful error handling builds user trust and prevents uninstalls. A centralized failure model across the architecture ensures no feature leaks raw exceptions to the UI.

**Independent Test**: Can be fully tested by simulating network failures and invalid data responses and verifying user-facing messages. Delivers value by ensuring reliability and trust.

**Acceptance Scenarios**:

1. **Given** a network request fails due to timeout, **When** the user is waiting for data, **Then** a localized error message is displayed with a "Retry" button.
2. **Given** an API returns an unexpected response format, **When** the data parsing fails, **Then** the app displays a generic error state without crashing, and the error is logged internally.
3. **Given** the user taps "Retry" after an error, **When** the network is restored, **Then** the data loads successfully and the error state is replaced with content.

---

### User Story 5 - Run and Pass Automated Tests (Priority: P3)

A developer (or CI pipeline) runs the test suite and all unit tests for use cases and repositories pass, all widget tests for key UI components pass, and mock dependencies are correctly injected. The test coverage provides confidence that refactoring or adding new features won't break existing functionality.

**Why this priority**: Testing is the backbone of maintainability. Without automated tests, every change carries risk. This story ensures the architecture supports testability by eliminating tight coupling.

**Independent Test**: Can be fully tested by running `flutter test` and verifying all tests pass with expected coverage. Delivers value by enabling safe, continuous development.

**Acceptance Scenarios**:

1. **Given** the test suite is run, **When** all unit tests for use cases execute, **Then** they pass with mocked repository dependencies.
2. **Given** the test suite is run, **When** all unit tests for repositories execute, **Then** they pass with mocked data source dependencies.
3. **Given** the test suite is run, **When** widget tests for key screens execute, **Then** they verify correct rendering of loading, error, and content states.

---

### Edge Cases

- What happens when the device runs critically low on storage and the cache cannot be written?
- How does the system handle a corrupted local cache? System clears the corrupted cache silently and re-fetches from the network; if offline, displays an error state with a retry option.
- What happens when the user rapidly switches between features before the previous screen finishes loading?
- How does the app behave when system fonts are scaled to very large sizes (accessibility settings)?
- What happens when the app is backgrounded during a network request and then resumed?
- How does the app handle RTL/LTR layout switching for Arabic and English content?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST organize code into three distinct layers — Presentation (UI + State Management via Cubits), Domain (Entities + Abstract Repository Interfaces), and Data (Repository Implementations + Data Sources + DTOs) — with no cross-layer dependencies violating the dependency rule.
- **FR-002**: System MUST use MVVM pattern with BLoC/Cubit as the state management solution, ensuring no business logic resides in UI widgets.
- **FR-003**: System MUST use dependency injection for all service and repository dependencies, enabling loose coupling and testability.
- **FR-004**: System MUST minimize unnecessary UI rebuilds by using immutable constructors, selective state observation, and memoization techniques where applicable.
- **FR-005**: System MUST use lazy loading and pagination for list-based content to prevent loading entire datasets into memory.
- **FR-006**: System MUST optimize scrollable lists by rendering only visible items on screen (virtualized rendering).
- **FR-007**: System MUST offload heavy computations to isolates to keep the main thread responsive.
- **FR-008**: System MUST follow SOLID principles — each class has a single responsibility, dependencies are abstracted via interfaces, and new features are addable without modifying existing code.
- **FR-009**: System MUST use immutable data models for all domain entities and DTOs.
- **FR-010**: System MUST implement the repository pattern with abstract interfaces in the domain layer and concrete implementations in the data layer, with separate remote and local data sources mapping DTOs to domain entities.
- **FR-011**: System MUST handle all API errors gracefully using a structured failure model (try/catch + typed Failure classes).
- **FR-012**: System MUST cache network data locally for offline access using a structured local storage solution. Static content (Quran, Azkar, Hadith) is cached indefinitely. Dynamic content (prayer times, radio streams) is refreshed on each access when online, or served from cache when offline.
- **FR-013**: System MUST provide unit tests for all cubit and repository implementations using mock dependencies.
- **FR-014**: System MUST provide widget tests for critical UI screens, covering loading, error, and content states.
- **FR-015**: System MUST support responsive layouts that adapt to different screen sizes and orientations.
- **FR-016**: System MUST support both dark and light themes with user preference persistence.
- **FR-017**: System MUST handle three UI states universally across all features: loading, error, and empty/content states.
- **FR-018**: System MUST provide a clear, documented folder structure with code organized in separate files by layer and feature.
- **FR-019**: System MUST use meaningful naming conventions throughout the codebase with comments explaining important architectural decisions.
- **FR-020**: System MUST support RTL (right-to-left) layout as the primary direction for Arabic content.

### Key Entities

- **Feature Module**: Represents an independent app feature (e.g., Quran, Prayer Times, Azkar). Contains its own presentation, domain, and data sub-layers. Can be developed, tested, and maintained independently.
- **Domain Entity**: An immutable business object representing core data (e.g., Prayer, Surah, Dhikr). Contains no framework dependencies. Defined in the domain layer.
- **DTO (Data Transfer Object)**: A mutable or serializable representation of data as received from APIs or local storage. Lives in the data layer and maps to/from domain entities.
- **Repository**: An abstraction (interface in domain, implementation in data) that orchestrates data fetching from remote and local sources, applying caching strategies. Cubits depend on the abstract interface, not the concrete implementation.
- **Failure**: A typed error model representing known error categories (network, cache, parsing, authentication) used consistently across all layers.
- **App Theme**: A configuration entity holding color schemes, typography, and shape definitions for both light and dark modes.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All screens load and become interactive within 2 seconds on a mid-range device.
- **SC-002**: Scrollable lists maintain 60fps rendering with no dropped frames during normal usage.
- **SC-003**: 100% of data-driven features are accessible offline using cached content after at least one successful online load.
- **SC-004**: No raw exception messages or stack traces are ever shown to the end user — all errors display localized, user-friendly messages.
- **SC-005**: Unit test coverage exists for all repository implementations (using mocked data sources), with all tests passing.
- **SC-006**: Widget tests cover loading, error, and content states for all critical screens.
- **SC-007**: Theme switching (dark/light) applies consistently across 100% of app screens with no visual inconsistencies.
- **SC-008**: App supports both Arabic (RTL) and English (LTR) layouts without overlapping or clipped content.
- **SC-009**: Adding a new feature module follows a documented template and takes no more than 30 minutes to scaffold. At least 2-3 existing pilot features are fully refactored as reference implementations.
- **SC-010**: No business logic exists in any UI widget — all logic is handled by cubits and repository abstractions.

## Assumptions

- The app targets mobile platforms (Android and iOS) as the primary deployment targets.
- Arabic (RTL) is the primary language, with English as a secondary language via `easy_localization`.
- Hive (via `hive_ce`) is the chosen local storage solution for caching, as it is already integrated in the project.
- GetIt is the chosen dependency injection container, as it is already integrated in the project.
- The existing feature-first folder structure (`lib/feature/<feature_name>/`) will be maintained and enhanced with Clean Architecture sub-layers.
- This iteration covers the core architecture foundation and 3 pilot feature refactors: **Azkar** (local JSON data pattern), **Quran** (remote API + caching + audio pattern), and **Prayer Times** (computed + API + notification pattern). The remaining 19 features will be migrated incrementally in subsequent iterations.
- Network requests are handled via Dio, which is already configured in the project.
- The app does not require user authentication for most features (Quran, Azkar, Prayer Times are accessible without login).
- BLoC/Cubit is the sole state management solution. No migration to Riverpod is planned; the existing 18+ cubits will be retained and refactored to align with Clean Architecture layers.
- Performance benchmarks assume a mid-range Android device (e.g., Samsung Galaxy A-series) as the baseline.
- The existing Cairo, Amiri, and SST Arabic font families will continue to be used for typography.
