class HadithModel {
  final int id;
  final String hadithArabic;
  final String? hadithEnglish;
  final String? hadithUrdu;
  final String? narrator;
  final String? status;
  final String? bookName;
  final String? chapterName;

  HadithModel({
    required this.id,
    required this.hadithArabic,
    this.hadithEnglish,
    this.hadithUrdu,
    this.narrator,
    this.status,
    this.bookName,
    this.chapterName,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'],
      hadithArabic: json['hadithArabic'] ?? '',
      hadithEnglish: json['hadithEnglish'],
      hadithUrdu: json['hadithUrdu'],
      narrator: json['englishNarrator'],
      status: json['status'],
      bookName: json['book']?['bookName'],
      chapterName: json['chapter']?['chapterArabic'],
    );
  }
}
