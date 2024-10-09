
import 'package:hive/hive.dart';

part 'productModel.g.dart';

@HiveType(typeId: 3)
class ProductModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  String? imagePath;

  @HiveField(2)
  String id;

  @HiveField(3)
  String categoryId; // Reference to the category

  @HiveField(4)
  String brand;

  @HiveField(5)
  double price;

  @HiveField(6)
  int quantity;

  @HiveField(7)
  String color;

  @HiveField(8)
  String description;

  

  
  ProductModel({
    required this.name,
    this.imagePath,
    required this.id,
    required this.categoryId,
    required this.brand,
    required this.color,
    required this.price,
    required this.quantity,
    required this.description
  });

  
}
