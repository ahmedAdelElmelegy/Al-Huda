import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/edition.dart';

class SurahModelData {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final List<Ayah> ayahs;
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
