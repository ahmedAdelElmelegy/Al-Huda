// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hifz_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HifzVerseAdapter extends TypeAdapter<HifzVerse> {
  @override
  final typeId = 10;

  @override
  HifzVerse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HifzVerse(
      surahIndex: (fields[0] as num).toInt(),
      ayahIndex: (fields[1] as num).toInt(),
      isMemorized: fields[2] == null ? false : fields[2] as bool,
      nextReviewDate: fields[3] as DateTime?,
      interval: fields[4] == null ? 1 : (fields[4] as num).toInt(),
      easeFactor: fields[5] == null ? 2.5 : (fields[5] as num).toDouble(),
      repetitionCount: fields[6] == null ? 0 : (fields[6] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, HifzVerse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.surahIndex)
      ..writeByte(1)
      ..write(obj.ayahIndex)
      ..writeByte(2)
      ..write(obj.isMemorized)
      ..writeByte(3)
      ..write(obj.nextReviewDate)
      ..writeByte(4)
      ..write(obj.interval)
      ..writeByte(5)
      ..write(obj.easeFactor)
      ..writeByte(6)
      ..write(obj.repetitionCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HifzVerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
