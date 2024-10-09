import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/sales_model.dart';

// Function to add a sale
Future<void> addSale(SalesModel sale) async {
  final salesBox = await Hive.openBox<SalesModel>('salesBox');

  //Reduce stock for each product in the sale
  for(final product in sale.products){
    await reduceProductQuantity(product.id, sale.saleQuantity);
  }
  await salesBox.add(sale);
  log('Sale added successfully');
}


// Function to get all sales
Future<List<SalesModel>> getAllSales() async {
  final salesBox = await Hive.openBox<SalesModel>('salesBox');
  return salesBox.values.toList();
}

// Function to delete a sale
Future<void> deleteSale(SalesModel sale) async {
  final salesBox = await Hive.openBox<SalesModel>('salesBox');
  final index =
      salesBox.values.toList().indexWhere((element) => element.id == sale.id);

  if (index != -1) {
    await salesBox.deleteAt(index);
    log('Sale deleted successfully');
  } else {
    log('Sale not found');
  }
}


// Function to get top-selling products
Future<Map<String, int>> getTopSellingProducts() async {
  final sales = await getAllSales();
  
  Map<String, int> productSales = {};

  for (var sale in sales) {
    for (var product in sale.products) {
      productSales[product.name] = (productSales[product.name] ?? 0) + sale.saleQuantity;
    }
  }

  final topSelling = productSales.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Map.fromEntries(topSelling.take(5));
}
//
Future<String> getProductNameById(String productId) async {
  final productBox = await Hive.openBox<ProductModel>('productBox'); // Ensure you're opening the correct box
  final product = productBox.get(productId);
  
  // Return the product name or an empty string if not found
  return product?.name ?? ''; // Change `name` to the appropriate field in your ProductModel
}

