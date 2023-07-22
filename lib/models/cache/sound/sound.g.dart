// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SoundModelAdapter extends TypeAdapter<SoundModel> {
  @override
  final int typeId = 4;

  @override
  SoundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SoundModel()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..resource_type_id = fields[2] as int
      ..res = fields[3] as String
      ..created_at = fields[4] as String
      ..updated_at = fields[5] as String
      ..size = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, SoundModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.resource_type_id)
      ..writeByte(3)
      ..write(obj.res)
      ..writeByte(4)
      ..write(obj.created_at)
      ..writeByte(5)
      ..write(obj.updated_at)
      ..writeByte(6)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
