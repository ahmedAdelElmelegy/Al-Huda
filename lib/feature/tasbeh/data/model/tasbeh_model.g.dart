// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasbeh_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasbehModelAdapter extends TypeAdapter<TasbehModel> {
  @override
  final typeId = 0;

  @override
  TasbehModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasbehModel(
      count: fields[0] == null ? 0 : (fields[0] as num).toInt(),
      name: fields[1] as String,
      lock: fields[2] == null ? false : (fields[2] as bool),
    );
  }

  @override
  void write(BinaryWriter writer, TasbehModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasbehModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
