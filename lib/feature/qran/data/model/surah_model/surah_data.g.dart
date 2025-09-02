// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahDataAdapter extends TypeAdapter<SurahData> {
  @override
  final typeId = 5;

  @override
  SurahData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahData(
      number: (fields[0] as num?)?.toInt(),
      name: fields[1] as String?,
      englishName: fields[2] as String?,
      englishNameTranslation: fields[3] as String?,
      numberOfAyahs: (fields[4] as num?)?.toInt(),
      revelationType: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SurahData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.englishName)
      ..writeByte(3)
      ..write(obj.englishNameTranslation)
      ..writeByte(4)
      ..write(obj.numberOfAyahs)
      ..writeByte(5)
      ..write(obj.revelationType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
