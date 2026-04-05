import 'package:hive_ce_flutter/hive_flutter.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 12)
class BookmarkModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int surahNumber;

  @HiveField(2)
  final int ayahNumber;

  @HiveField(3)
  final String text;

  @HiveField(4)
  final DateTime timestamp;

  BookmarkModel({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.text,
    required this.timestamp,
  });
}
