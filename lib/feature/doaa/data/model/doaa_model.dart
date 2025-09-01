// ad3yah_model.dart

import 'package:hive_ce_flutter/hive_flutter.dart';

part 'doaa_model.g.dart';

@HiveType(typeId: 3)
class DoaaModelData {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String info;
  @HiveField(3)
  String? category;

  DoaaModelData({
    required this.id,
    required this.text,
    required this.info,
    this.category,
  });

  DoaaModelData copyWith({String? id, String? text, String? info}) {
    return DoaaModelData(
      id: id ?? this.id,
      text: text ?? this.text,
      info: info ?? this.info,
      category: category,
    );
  }

  factory DoaaModelData.fromJson(Map<String, dynamic> json) {
    return DoaaModelData(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      info: json['info'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'info': info, 'category': category};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DoaaModelData &&
        other.id == id &&
        other.text == text &&
        other.info == info &&
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(id, text, info, category);

  @override
  String toString() =>
      'DoaaModel(id: $id, text: $text, info: $info, category: $category)';
}
