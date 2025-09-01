import 'package:hive_ce_flutter/hive_flutter.dart';

part 'zikr.g.dart';

@HiveType(typeId: 1)
class Zikr {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  int count;
  @HiveField(3)
  final String audio;
  @HiveField(4)
  final String filename;

  Zikr({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      audio: json['audio'],
      filename: json['filename'],
    );
  }
  Zikr copyWith({
    String? text,
    int? count,
    String? audio,
    String? filename,
    int? id,
    // other parameters...
  }) {
    return Zikr(
      id: id ?? this.id,
      text: text ?? this.text,
      count: count ?? this.count,
      audio: audio ?? this.audio,
      filename: filename ?? this.filename,
      // copy other properties...
    );
  }
}
