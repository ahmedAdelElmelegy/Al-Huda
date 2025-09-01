// ad3yah_model.dart

class DoaaModelData {
  final String id;
  final String text;
  final String info;

  DoaaModelData({required this.id, required this.text, required this.info});

  DoaaModelData copyWith({String? id, String? text, String? info}) {
    return DoaaModelData(
      id: id ?? this.id,
      text: text ?? this.text,
      info: info ?? this.info,
    );
  }

  factory DoaaModelData.fromJson(Map<String, dynamic> json) {
    return DoaaModelData(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      info: json['info'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'info': info};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DoaaModelData &&
        other.id == id &&
        other.text == text &&
        other.info == info;
  }

  @override
  int get hashCode => Object.hash(id, text, info);

  @override
  String toString() => 'DoaaModel(id: $id, text: $text, info: $info)';
}
