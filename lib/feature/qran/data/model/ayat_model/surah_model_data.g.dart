// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahModelDataAdapter extends TypeAdapter<SurahModelData> {
  @override
  final typeId = 6;

  @override
  SurahModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahModelData(
      number: (fields[0] as num).toInt(),
      name: fields[1] as String,
      englishName: fields[2] as String,
      englishNameTranslation: fields[3] as String,
      revelationType: fields[4] as String,
      numberOfAyahs: (fields[5] as num).toInt(),
      ayahs: (fields[6] as List).cast<Ayah>(),
      edition: fields[7] as Edition,
    );
  }

  @override
  void write(BinaryWriter writer, SurahModelData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.englishName)
      ..writeByte(3)
      ..write(obj.englishNameTranslation)
      ..writeByte(4)
      ..write(obj.revelationType)
      ..writeByte(5)
      ..write(obj.numberOfAyahs)
      ..writeByte(6)
      ..write(obj.ayahs)
      ..writeByte(7)
      ..write(obj.edition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
