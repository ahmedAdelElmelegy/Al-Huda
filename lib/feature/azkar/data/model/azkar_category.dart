import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import '../../domain/entities/azkar_category_entity.dart';

class AzkarCategory {
  final int id;
  final String name;
  final String audio;
  final String filename;
  final List<Zikr> azkar;

  AzkarCategory({
    required this.id,
    required this.name,
    required this.audio,
    required this.filename,
    required this.azkar,
  });

  AzkarCategoryEntity toEntity() {
    return AzkarCategoryEntity(
      id: id,
      name: name,
      audio: audio,
      filename: filename,
      azkar: azkar.map((z) => z.toEntity()).toList(),
    );
  }

  factory AzkarCategory.fromJson(Map<String, dynamic> json) {
    var list = json['array'] as List;
    List<Zikr> azkarList = list.map((i) => Zikr.fromJson(i)).toList();

    return AzkarCategory(
      id: json['id'],
      name: json['category'],
      audio: json['audio'],
      filename: json['filename'],
      azkar: azkarList,
    );
  }
}
