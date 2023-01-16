// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharityModelFirstAdapter extends TypeAdapter<CharityModelFirst> {
  @override
  final int typeId = 1;

  @override
  CharityModelFirst read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharityModelFirst(
      id: fields[0] as int?,
      typeName: fields[1] as String?,
      sub: fields[2] as int?,
      optionalSubSelect: fields[3] as int?,
      title: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharityModelFirst obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeName)
      ..writeByte(2)
      ..write(obj.sub)
      ..writeByte(3)
      ..write(obj.optionalSubSelect)
      ..writeByte(4)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharityModelFirstAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharityModelSecandAdapter extends TypeAdapter<CharityModelSecand> {
  @override
  final int typeId = 2;

  @override
  CharityModelSecand read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharityModelSecand(
      id: fields[0] as int?,
      typeName: fields[1] as String?,
      sub: fields[2] as int?,
      optionalSubSelect: fields[3] as int?,
      title: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharityModelSecand obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeName)
      ..writeByte(2)
      ..write(obj.sub)
      ..writeByte(3)
      ..write(obj.optionalSubSelect)
      ..writeByte(4)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharityModelSecandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
