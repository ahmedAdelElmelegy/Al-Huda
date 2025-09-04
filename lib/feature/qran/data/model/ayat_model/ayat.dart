import 'package:hive_ce_flutter/hive_flutter.dart';

part 'ayat.g.dart';

@HiveType(typeId: 7)
class Ayah {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String audio;
  @HiveField(2)
  final List<String> audioSecondary;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final int numberInSurah;
  @HiveField(5)
  final int juz;
  @HiveField(6)
  final int manzil;
  @HiveField(7)
  final int page;
  @HiveField(8)
  final int ruku;
  @HiveField(9)
  final int hizbQuarter;
  @HiveField(10)
  final bool sajda;

  Ayah({
    required this.number,
    required this.audio,
    required this.audioSecondary,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    List<String> audioSecondary =
        (json['audioSecondary'] as List<dynamic>?)?.cast<String>() ?? [];
    bool sajdaValue = false;
    if (json['sajda'] != null) {
      if (json['sajda'] is bool) {
        sajdaValue = json['sajda'];
      } else if (json['sajda'] is Map<String, dynamic>) {
        sajdaValue = (json['sajda']['recommended'] ?? false) as bool;
      }
    }
    return Ayah(
      number: json['number'],
      audio: json['audio'],
      audioSecondary: audioSecondary,
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: sajdaValue,
    );
  }
  Ayah copyWith({
    int? number,
    String? audio,
    List<String>? audioSecondary,
    String? text,
    int? numberInSurah,
    int? juz,
    int? manzil,
    int? page,
    int? ruku,
    int? hizbQuarter,
    bool? sajda,
  }) {
    return Ayah(
      number: number ?? this.number,
      audio: audio ?? this.audio,
      audioSecondary: audioSecondary ?? this.audioSecondary,
      text: text ?? this.text,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      juz: juz ?? this.juz,
      manzil: manzil ?? this.manzil,
      page: page ?? this.page,
      ruku: ruku ?? this.ruku,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      sajda: sajda ?? this.sajda,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'audio': audio,
      'audioSecondary': audioSecondary,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
    };
  }
}
