import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/edition.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'surah_model_data.g.dart';

@HiveType(typeId: 6)
class SurahModelData {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String englishName;

  @HiveField(3)
  final String englishNameTranslation;

  @HiveField(4)
  final String revelationType;

  @HiveField(5)
  final int numberOfAyahs;

  @HiveField(6)
  final List<Ayah> ayahs;

  @HiveField(7)
  final Edition edition;

  SurahModelData({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
    required this.edition,
  });

  factory SurahModelData.fromJson(Map<String, dynamic> json) {
    var ayahsList = json['ayahs'] as List;
    List<Ayah> ayahs = ayahsList.map((i) => Ayah.fromJson(i)).toList();

    return SurahModelData(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      numberOfAyahs: json['numberOfAyahs'],
      ayahs: ayahs,
      edition: Edition.fromJson(json['edition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'ayahs': ayahs.map((ayah) => ayah.toJson()).toList(),
      'edition': edition.toJson(),
    };
  }
}
