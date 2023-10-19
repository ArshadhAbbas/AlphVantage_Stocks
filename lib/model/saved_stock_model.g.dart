// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_stock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedStockModelAdapter extends TypeAdapter<SavedStockModel> {
  @override
  final int typeId = 1;

  @override
  SavedStockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedStockModel(
      companyName: fields[1] as String,
      companySymbol: fields[2] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedStockModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.companySymbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedStockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
