import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:project/model_classes/usermodel.dart';

Future<void> addCategory(CategoryModel category) async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_db');
  await categoryBox.add(category);
  log('Category added successfully');
}

//
// Future<void> addcat(CategoryModel category) async {
//   final catbox = await Hive.openBox<CategoryModel>('boxname');
//   await catbox.add(category);
// }

// Future<List<CategoryModel>> getcat() async {
//   final catbox = await Hive.openBox<CategoryModel>('boxnmae');
//   return catbox.values.toList();
// }

Future<List<CategoryModel>> getAllCatogories() async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_db');
  return categoryBox.values.toList();
}

Future<void> deleteCategory(CategoryModel category) async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_db');
  final index = categoryBox.values
      .toList()
      .indexWhere((element) => element.id == category.id);
  categoryBox.deleteAt(index);
}
