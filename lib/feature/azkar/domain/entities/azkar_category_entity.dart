import 'package:equatable/equatable.dart';
import 'zikr_entity.dart';

class AzkarCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String audio;
  final String filename;
  final List<ZikrEntity> azkar;

  const AzkarCategoryEntity({
    required this.id,
    required this.name,
    required this.audio,
    required this.filename,
    required this.azkar,
  });

  @override
  List<Object?> get props => [id, name, audio, filename, azkar];
}
