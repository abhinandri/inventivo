
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/pages/inventory_page/products_things/edit_products.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  void _navigateToEditPage() async {
    final updatedProduct = await Navigator.push<ProductModel>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(product: _product),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        _product = updatedProduct;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _navigateToEditPage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[200],
      child: _product.imagePath != null && File(_product.imagePath!).existsSync()
          ? Image.file(
              File(_product.imagePath!),
              fit: BoxFit.contain,
            )
          : Icon(Icons.inventory_2, size: 80, color: Colors.grey[400]),
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _product.name,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          _buildDetailCard(),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow('Category', _product.categoryId),
            _buildDetailRow('Brand', _product.brand),
            _buildDetailRow('Price', '\₹${_product.price.toStringAsFixed(2)}'),
            _buildDetailRow('Quantity', _product.quantity.toString()),
            _buildDetailRow('Color', _product.color),
            _buildDetailRow('Descrption',_product.description.toString())
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
