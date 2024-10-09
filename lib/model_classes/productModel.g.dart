// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 3;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      name: fields[0] as String,
      imagePath: fields[1] as String?,
      id: fields[2] as String,
      categoryId: fields[3] as String,
      brand: fields[4] as String,
      color: fields[7] as String,
      price: fields[5] as double,
      quantity: fields[6] as int,
      description: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
