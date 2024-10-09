
   
import 'package:hive_flutter/hive_flutter.dart';
    part 'brandmodel.g.dart';

@HiveType(typeId: 6)
class BrandModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? imagePath;

  @HiveField(2)
  String id;
  

  BrandModel({
    required this.name,
    this.imagePath,
    required this.id,
  });
}
