class SurahData {
  int? number;
  final String? name;
  final String? englishName;
  final String? englishNameTranslation;
  final int? numberOfAyahs;
  final String? revelationType;

  SurahData({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory SurahData.fromJson(Map<String, dynamic> json) {
    return SurahData(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'numberOfAyahs': numberOfAyahs,
      'revelationType': revelationType,
    };
  }
}
