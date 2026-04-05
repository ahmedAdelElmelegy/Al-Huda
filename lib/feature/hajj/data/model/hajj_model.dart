class HajjUmrahData {
  final List<HajjStep> hajj;
  final List<HajjStep> umrah;
  final List<HajjDua> duas;

  HajjUmrahData({
    required this.hajj,
    required this.umrah,
    required this.duas,
  });

  factory HajjUmrahData.fromJson(Map<String, dynamic> json) {
    return HajjUmrahData(
      hajj: (json['hajj'] as List).map((e) => HajjStep.fromJson(e)).toList(),
      umrah: (json['umrah'] as List).map((e) => HajjStep.fromJson(e)).toList(),
      duas: (json['duas'] as List).map((e) => HajjDua.fromJson(e)).toList(),
    );
  }
}

class HajjStep {
  final int step;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;

  HajjStep({
    required this.step,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  factory HajjStep.fromJson(Map<String, dynamic> json) {
    return HajjStep(
      step: json['step'],
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
    );
  }

  String getTitle(bool isArabic) => isArabic ? titleAr : titleEn;
  String getDescription(bool isArabic) => isArabic ? descriptionAr : descriptionEn;
}

class HajjDua {
  final String titleAr;
  final String titleEn;
  final String textAr;
  final String textEn;

  HajjDua({
    required this.titleAr,
    required this.titleEn,
    required this.textAr,
    required this.textEn,
  });

  factory HajjDua.fromJson(Map<String, dynamic> json) {
    return HajjDua(
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      textAr: json['text_ar'],
      textEn: json['text_en'],
    );
  }

  String getTitle(bool isArabic) => isArabic ? titleAr : titleEn;
  String getText(bool isArabic) => isArabic ? textAr : textEn;
}
