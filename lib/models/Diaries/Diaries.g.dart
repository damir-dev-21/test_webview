// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Diaries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiariesAdapter extends TypeAdapter<Diaries> {
  @override
  final int typeId = 2;

  @override
  Diaries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diaries(
      (fields[0] as List).cast<Diary>(),
    );
  }

  @override
  void write(BinaryWriter writer, Diaries obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.diaries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiariesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
