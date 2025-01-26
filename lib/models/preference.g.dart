// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferenceAdapter extends TypeAdapter<Preference> {
  @override
  final int typeId = 2;

  @override
  Preference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preference(
      sortOption: fields[0] as sortOptions,
      isDarkMode: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Preference obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sortOption)
      ..writeByte(1)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class sortOptionsAdapter extends TypeAdapter<sortOptions> {
  @override
  final int typeId = 1;

  @override
  sortOptions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return sortOptions.dateAsc;
      case 1:
        return sortOptions.dateDesc;
      case 2:
        return sortOptions.titleAsc;
      case 3:
        return sortOptions.titleDesc;
      default:
        return sortOptions.dateAsc;
    }
  }

  @override
  void write(BinaryWriter writer, sortOptions obj) {
    switch (obj) {
      case sortOptions.dateAsc:
        writer.writeByte(0);
        break;
      case sortOptions.dateDesc:
        writer.writeByte(1);
        break;
      case sortOptions.titleAsc:
        writer.writeByte(2);
        break;
      case sortOptions.titleDesc:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is sortOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
