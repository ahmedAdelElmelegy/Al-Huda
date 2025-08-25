class Zikr {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  Zikr({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      audio: json['audio'],
      filename: json['filename'],
    );
  }
}
