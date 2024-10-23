import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';

class addSaleList extends StatelessWidget {
  const addSaleList({
    super.key,
    required this.filteredProducts,
  });

  final List<ProductModel> filteredProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return Card( // Added Card for better styling
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(product.name),
            subtitle: Text('Price: \₹${product.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.of(context).pop(product);
            },
          ),
        );
      },
    );
  }
}