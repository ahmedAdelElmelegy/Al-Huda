class Ayah {
  final int number;
  final String audio;
  final List<String> audioSecondary;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
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
