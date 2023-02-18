// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryAdapter extends TypeAdapter<Diary> {
  @override
  final int typeId = 1;

  @override
  Diary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diary(
      fields[0] as int,
      fields[1] as int,
      (fields[2] as List).cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, Diary obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.week)
      ..writeByte(2)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
