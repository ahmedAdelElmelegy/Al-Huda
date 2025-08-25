import 'package:al_huda/feature/azkar/data/model/zikr.dart';

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
