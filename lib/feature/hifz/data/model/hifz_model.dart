import 'package:hive_ce_flutter/hive_flutter.dart';

part 'hifz_model.g.dart';

@HiveType(typeId: 10)
class HifzVerse extends HiveObject {
  @HiveField(0)
  final int surahIndex; // 1-based

  @HiveField(1)
  final int ayahIndex; // 1-based

  @HiveField(2)
  bool isMemorized;

  @HiveField(3)
  DateTime? nextReviewDate;

  @HiveField(4)
  int interval; // in days

  @HiveField(5)
  double easeFactor;

  @HiveField(6)
  int repetitionCount;

  HifzVerse({
    required this.surahIndex,
    required this.ayahIndex,
    this.isMemorized = false,
    this.nextReviewDate,
    this.interval = 1,
    this.easeFactor = 2.5,
    this.repetitionCount = 0,
  });

  @override
  String get key => '$surahIndex:$ayahIndex';
}
