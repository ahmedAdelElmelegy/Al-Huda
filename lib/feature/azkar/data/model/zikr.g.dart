// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zikr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZikrAdapter extends TypeAdapter<Zikr> {
  @override
  final typeId = 1;

  @override
  Zikr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Zikr(
      id: (fields[0] as num).toInt(),
      text: fields[1] as String,
      count: (fields[2] as num).toInt(),
      audio: fields[3] as String,
      filename: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Zikr obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.audio)
      ..writeByte(4)
      ..write(obj.filename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZikrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
