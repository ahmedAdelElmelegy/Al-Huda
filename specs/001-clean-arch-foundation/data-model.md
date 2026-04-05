# Data Model: Clean Architecture Foundation

**Branch**: `001-clean-arch-foundation` | **Date**: 2026-04-05

This document outlines the core domain entities and their mapped DTOs for the 3 pilot features being refactored.

## Core Architectural Entities

### `Result<T>` (Sealed Class)
The universal return type for repository operations.
- `Success<T>(T data)`
- `Error<T>(Failure failure)`

### `Failure` (Abstract Class, Equatable)
Base error model. Subtypes:
- `ServerFailure`: Network and API errors (from Dio)
- `CacheFailure`: Local storage and Hive errors
- `ParsingFailure`: Data format and serialization errors

## Feature: Azkar

### `AzkarCategoryEntity` (Domain)
- `name` (String): The category name
- `azkar` (List<ZikrEntity>): List of dhikr items in this category

### `ZikrEntity` (Domain)
- `id` (int): Unique identifier
- `text` (String): The text content of the dhikr
- `count` (int): Required repetition count
- `audio` (String): Audio file reference
- `filename` (String): Associated file name

**DTO Mapping**: `AzkarCategory` (DTO) and `Zikr` (DTO) will retain their `@HiveType` and `@HiveField` annotations and add a `toEntity()` method.

## Feature: Quran

### `SurahEntity` (Domain)
- `number` (int): Surah number (1-114)
- `name` (String): Arabic name (e.g., "سورة الفاتحة")
- `englishName` (String): Transliterated name (e.g., "Al-Faatiha")
- `englishNameTranslation` (String): Translated meaning
- `numberOfAyahs` (int): Total verses
- `revelationType` (String): Meccan or Medinan

### `AyatEntity` (Domain)
- `number` (int): Ayah number overall
- `numberInSurah` (int): Ayah number within its Surah
- `text` (String): The full Arabic text of the verse
- `audio` (String?): URL to audio recitation
- `surahNumber` (int): The Surah it belongs to
- `page` (int): Quran page number
- `hizbQuarter` (int): Hizb quarter marker
- `juz` (int): Juz marker

**DTO Mapping**: Existing Quran and Ayat models will be wrapped in DTOs matching the network/cache response structures and convert to these pure entities.

## Feature: Prayer Times

### `PrayerTimeEntity` (Domain)
- `fajr` (String): Formatted time for Fajr
- `sunrise` (String): Formatted time for Sunrise
- `dhuhr` (String): Formatted time for Dhuhr
- `asr` (String): Formatted time for Asr
- `maghrib` (String): Formatted time for Maghrib
- `isha` (String): Formatted time for Isha
- `date` (DateTime): The Gregorian or Hijri date this represents
- `meta` (PrayerMetaEntity): Contains timezone, calculation method, etc.

**DTO Mapping**: The Aladhan API response contains nested 'timings' and 'date' objects. The DTO parses the complex JSON and maps it to a flat, UI-friendly `PrayerTimeEntity` using `toEntity()`.

## Validation Rules & State Transitions

- **Immutability**: All domain entities MUST be immutable, using `final` fields and extending `Equatable`.
- **Transformation**: DTOs MUST not cross into the Presentation layer. The Repository implementation is responsible for calling `.toEntity()` on the DTO.
- **Cache Persistence**: Only DTOs are saved to Hive. Domain entities are converted back to DTOs if they need to be saved (e.g. `ZikrEntity.toDTO()`) or the repository operates directly on DTOs internally before returning entities.
