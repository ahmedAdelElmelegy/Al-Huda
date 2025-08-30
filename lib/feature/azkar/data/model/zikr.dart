class Zikr {
  final int id;
  final String text;
  int count;
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
  Zikr copyWith({
    String? text,
    int? count,
    String? audio,
    String? filename,
    int? id,
    // other parameters...
  }) {
    return Zikr(
      id: id ?? this.id,
      text: text ?? this.text,
      count: count ?? this.count,
      audio: audio ?? this.audio,
      filename: filename ?? this.filename,
      // copy other properties...
    );
  }
}
