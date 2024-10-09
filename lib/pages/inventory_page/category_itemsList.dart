
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/pages/inventory_page/products_details_page.dart';

class CategoryProductListPage extends StatefulWidget {
  final String categoryName;

  CategoryProductListPage({required this.categoryName});

  @override
  _CategoryProductListPageState createState() => _CategoryProductListPageState();
}

class _CategoryProductListPageState extends State<CategoryProductListPage> {
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoryProducts();
  }

  void _fetchCategoryProducts() async {
    final products = await getProductsByCategory(widget.categoryName);
    setState(() {
      _products = products;
    });
  }

  Future<void> _deleteProduct(ProductModel product) async {
    // Implement your delete logic here
    await deleteProduct(product); // Replace with your actual delete function
    _fetchCategoryProducts(); // Refresh the product list
  }

  void _showDeleteConfirmationDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete ${product.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(product);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.categoryName}'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: product.imagePath != null && File(product.imagePath!).existsSync()
                ? Image.file(
                    File(product.imagePath!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.shopping_bag),
            title: Text(product.name),
            subtitle: Text('Price: ${product.price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
            onLongPress: () {
              _showDeleteConfirmationDialog(product);
            },
          );
        },
      ),
    );
  }
}
