// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHistoryAdapter extends TypeAdapter<FavoriteHistory> {
  @override
  final int typeId = 0;

  @override
  FavoriteHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHistory(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.bg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
