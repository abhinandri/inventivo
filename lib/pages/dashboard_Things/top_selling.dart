 import 'package:hive/hive.dart';

Future<Map<String, int>> fetchTopSellingProducts() async {
  print("Fetching top-selling products...");
  final box = Hive.box('sales');
  final Map<String, int> products = {};

  for (var sale in box.values) {
    final productName = sale['productName'];
    final quantity = (sale['quantity'] as num).toInt();

    if (products.containsKey(productName)) {
      products[productName] = products[productName]! + quantity;
    } else {
      products[productName] = quantity;
    }
  }

  print("Fetched products: $products");
  return products;
}