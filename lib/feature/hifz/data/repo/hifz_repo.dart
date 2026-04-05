import 'package:hive_ce_flutter/hive_flutter.dart';
import '../model/hifz_model.dart';

abstract class HifzRepo {
  List<HifzVerse> getMemorizedVerses(int surahIndex);
  Future<void> markAsMemorized(int surahIndex, int ayahIndex);
  Future<void> unmarkAsMemorized(int surahIndex, int ayahIndex);
  Future<void> markAsReviewed(int surahIndex, int ayahIndex, bool success);
  List<HifzVerse> getDueVerses();
  double getSurahProgress(int surahIndex, int totalAyahs);
  double getTotalProgress(int totalAyaInQuran);
}

class HifzRepoImpl implements HifzRepo {
  final Box<HifzVerse> _hifzBox = Hive.box<HifzVerse>('hifz_verses');

  @override
  List<HifzVerse> getMemorizedVerses(int surahIndex) {
    return _hifzBox.values
        .where((v) => (surahIndex == -1 || v.surahIndex == surahIndex) && v.isMemorized)
        .toList();
  }

  @override
  Future<void> markAsMemorized(int surahIndex, int ayahIndex) async {
    final key = '$surahIndex:$ayahIndex';
    final verse = _hifzBox.get(key) ?? HifzVerse(surahIndex: surahIndex, ayahIndex: ayahIndex);
    
    verse.isMemorized = true;
    verse.interval = 1;
    verse.repetitionCount = 1;
    verse.easeFactor = 2.5;
    verse.nextReviewDate = DateTime.now().add(const Duration(days: 1));
    
    await _hifzBox.put(key, verse);
  }

  @override
  Future<void> unmarkAsMemorized(int surahIndex, int ayahIndex) async {
    final key = '$surahIndex:$ayahIndex';
    final verse = _hifzBox.get(key);
    if (verse != null) {
      verse.isMemorized = false;
      verse.nextReviewDate = null;
      verse.repetitionCount = 0;
      await verse.save();
    }
  }

  @override
  Future<void> markAsReviewed(int surahIndex, int ayahIndex, bool success) async {
    final key = '$surahIndex:$ayahIndex';
    final verse = _hifzBox.get(key);
    if (verse == null || !verse.isMemorized) return;

    // SM-2 SRS Algorithm
    // Quality mapping: success -> 4 (good), failure -> 0 (blackout)
    final quality = success ? 4 : 0;

    if (quality >= 3) {
      // Success
      if (verse.repetitionCount == 0) {
        verse.interval = 1;
      } else if (verse.repetitionCount == 1) {
        verse.interval = 6;
      } else {
        verse.interval = (verse.interval * verse.easeFactor).round();
      }
      verse.repetitionCount++;
    } else {
      // Failure
      verse.repetitionCount = 0;
      verse.interval = 1;
    }

    // Update ease factor: EF' = EF + (0.1 - (5-q)*(0.08 + (5-q)*0.02))
    verse.easeFactor = (verse.easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)));
    if (verse.easeFactor < 1.3) verse.easeFactor = 1.3;

    verse.nextReviewDate = DateTime.now().add(Duration(days: verse.interval));
    await verse.save();
  }

  @override
  List<HifzVerse> getDueVerses() {
    final now = DateTime.now();
    return _hifzBox.values
        .where((v) => v.isMemorized && v.nextReviewDate != null && v.nextReviewDate!.isBefore(now))
        .toList();
  }

  @override
  double getSurahProgress(int surahIndex, int totalAyahs) {
    if (totalAyahs <= 0) return 0.0;
    final memorizedCount = _hifzBox.values
        .where((v) => v.surahIndex == surahIndex && v.isMemorized)
        .length;
    return memorizedCount / totalAyahs;
  }

  @override
  double getTotalProgress(int totalAyaInQuran) {
    if (totalAyaInQuran <= 0) return 0.0;
    final totalMemorized = _hifzBox.values.where((v) => v.isMemorized).length;
    return totalMemorized / totalAyaInQuran;
  }
}
