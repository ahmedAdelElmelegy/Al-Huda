import 'package:equatable/equatable.dart';

class HadithModel extends Equatable {
  final int id;
  final String hadithArabic;
  final String hadithEnglish;
  final String hadithUrdu;
  final String englishNarrator;
  final String muslimNarrator;
  final String status;
  final String bookName;
  final String chapterName;

  const HadithModel({
    required this.id,
    required this.hadithArabic,
    required this.hadithEnglish,
    required this.hadithUrdu,
    required this.englishNarrator,
    required this.muslimNarrator,
    required this.status,
    required this.bookName,
    required this.chapterName,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'] ?? 0,
      hadithArabic: json['hadithArabic'] ?? "",
      hadithEnglish: json['hadithEnglish'] ?? "",
      hadithUrdu: json['hadithUrdu'] ?? "",
      englishNarrator: json['englishNarrator'] ?? "",
      muslimNarrator: json['muslimNarrator'] ?? "",
      status: json['status'] ?? "",
      bookName: json['book']?['bookName'] ?? "",
      chapterName: json['chapter']?['chapterName'] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    hadithArabic,
    hadithEnglish,
    hadithUrdu,
    englishNarrator,
    muslimNarrator,
    status,
    bookName,
    chapterName,
  ];
}
