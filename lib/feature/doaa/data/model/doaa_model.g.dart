// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doaa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoaaModelDataAdapter extends TypeAdapter<DoaaModelData> {
  @override
  final typeId = 3;

  @override
  DoaaModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoaaModelData(
      id: fields[0] as String,
      text: fields[1] as String,
      info: fields[2] as String,
      category: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DoaaModelData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.info)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoaaModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
