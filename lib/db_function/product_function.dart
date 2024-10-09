
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/model_classes/productModel.dart';

ValueNotifier<List<ProductModel>> productListNotifier = ValueNotifier([]);

Future<void> addOrUpdateProduct(ProductModel product) async {
  final box = await Hive.openBox<ProductModel>('products');

  // Update or add the product
  await box.put(product.id, product);

  // Update the notifier and refresh the product list
  productListNotifier.value = List<ProductModel>.from(box.values);
  productListNotifier.notifyListeners();
}

Future<List<ProductModel>> getAllProducts() async { 
  final box = await Hive.openBox<ProductModel>('products');
  productListNotifier.value = List<ProductModel>.from(box.values);
  productListNotifier.notifyListeners();
  return box.values.toList();
}

Future<void> deleteProduct(ProductModel product) async {
  final box = await Hive.openBox<ProductModel>('products');

  // Delete the product
  await box.delete(product.id);

  // Update the notifier and refresh the product list
  productListNotifier.value = List<ProductModel>.from(box.values);
  productListNotifier.notifyListeners();
}

Future<void> updateProduct(ProductModel product) async {
  await addOrUpdateProduct(product);
}

Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
  final allProducts = await getAllProducts();
  return allProducts.where((product) => product.categoryId == categoryId).toList();
}

Future<List<ProductModel>> getProductsByBrand(String brandName) async {
  final allProducts = await getAllProducts();
  return allProducts.where((product) => product.brand == brandName).toList();
}

Future<void> reduceProductQuantity(String productId, int quantitySold,) async {
  final box = await Hive.openBox<ProductModel>('products');

  final product = box.get(productId);
  if (product != null) {  
    // Check if enough stock is available
    if (product.quantity >= quantitySold) {
      product.quantity -= quantitySold; // Reduce quantity
      await box.put(productId, product); // Update the product in the box
    } else {
      throw Exception('Not enough stock available for product: ${product.name}');
    }
  }
}

