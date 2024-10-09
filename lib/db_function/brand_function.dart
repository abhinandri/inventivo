import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:project/model_classes/brandmodel.dart';

Future<void> addBrand(BrandModel brand) async {
  final brandBox = await Hive.openBox<BrandModel>('brand_db');
  await brandBox.add(brand);
  log('Brand added successfully');
}

Future<List<BrandModel>> getAllBrands() async {
  final brandBox = await Hive.openBox<BrandModel>('brand_db');
  return brandBox.values.toList();
}

Future<void> deleteBrand(BrandModel brand) async {
  final brandBox = await Hive.openBox<BrandModel>('brand_db');
  final index = brandBox.values.toList().indexWhere((element) => element.id == brand.id);
  if (index != -1) {
    await brandBox.deleteAt(index);
    log('Brand deleted successfully');
  } else {
    log('Brand not found');
  }
}
