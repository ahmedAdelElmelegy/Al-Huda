import 'package:equatable/equatable.dart';

class ZikrEntity extends Equatable {
  final int id;
  final String text;
  int count;
  final String audio;
  final String filename;

  ZikrEntity({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  @override
  List<Object?> get props => [id, text, count, audio, filename];
}
