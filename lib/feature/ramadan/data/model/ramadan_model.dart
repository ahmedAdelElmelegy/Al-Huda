class RamadanData {
  final List<RamadanAction> dailyActions;
  final List<RamadanTip> tips;

  RamadanData({
    required this.dailyActions,
    required this.tips,
  });

  factory RamadanData.fromJson(Map<String, dynamic> json) {
    return RamadanData(
      dailyActions: (json['daily_actions'] as List)
          .map((e) => RamadanAction.fromJson(e))
          .toList(),
      tips: (json['tips'] as List).map((e) => RamadanTip.fromJson(e)).toList(),
    );
  }
}

class RamadanAction {
  final int id;
  final String titleAr;
  final String titleEn;
  final String contentAr;
  final String contentEn;
  final String icon;

  RamadanAction({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.contentAr,
    required this.contentEn,
    required this.icon,
  });

  factory RamadanAction.fromJson(Map<String, dynamic> json) {
    return RamadanAction(
      id: json['id'],
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      contentAr: json['content_ar'],
      contentEn: json['content_en'],
      icon: json['icon'],
    );
  }

  String getTitle(bool isArabic) => isArabic ? titleAr : titleEn;
  String getContent(bool isArabic) => isArabic ? contentAr : contentEn;
}

class RamadanTip {
  final String ar;
  final String en;

  RamadanTip({
    required this.ar,
    required this.en,
  });

  factory RamadanTip.fromJson(Map<String, dynamic> json) {
    return RamadanTip(
      ar: json['ar'],
      en: json['en'],
    );
  }

  String getTip(bool isArabic) => isArabic ? ar : en;
}
