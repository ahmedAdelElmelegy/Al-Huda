import 'package:hive_ce_flutter/hive_flutter.dart';

part 'edition.g.dart';

@HiveType(typeId: 8)
class Edition {
  @HiveField(0)
  final String identifier;
  @HiveField(1)
  final String language;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String englishName;
  @HiveField(4)
  final String format;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final dynamic direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) {
    return Edition(
      identifier: json['identifier'],
      language: json['language'],
      name: json['name'],
      englishName: json['englishName'],
      format: json['format'],
      type: json['type'],
      direction: json['direction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'language': language,
      'name': name,
      'englishName': englishName,
      'format': format,
      'type': type,
      'direction': direction,
    };
  }
}
