// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:project/model_classes/productModel.dart';
// import 'package:project/db_function/product_function.dart';
// import 'package:project/pages/inventory_page/products_details_page.dart';

// class BrandProductListPage extends StatefulWidget {
//   final String brandName;

//   BrandProductListPage({required this.brandName});

//   @override
//   _BrandProductListPageState createState() => _BrandProductListPageState();
// }

// class _BrandProductListPageState extends State<BrandProductListPage> {
//   List<ProductModel> _products = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBrandProducts();
//   }

//   void _fetchBrandProducts() async {
//     final products = await getProductsByBrand(widget.brandName);
//     setState(() {
//       _products = products;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products by ${widget.brandName}'),
//       ),
//       body: ListView.builder(
//         itemCount: _products.length,
//         itemBuilder: (context, index) {
//           final product = _products[index];
//           return ListTile(
//              leading: product.imagePath != null && File(product.imagePath!).existsSync()
//             ? Image.file(
//                 File(product.imagePath!),
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ):
//                  Icon(Icons.shopping_bag),
//                   title: Text(product.name),
//             subtitle: Text('Price: ${product.price}'),
//              onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProductDetailsPage(product: product),
//             ),
//           );
//         },  
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/pages/inventory_page/products_details_page.dart';

class BrandProductListPage extends StatefulWidget {
  final String brandName;

  BrandProductListPage({required this.brandName});

  @override
  _BrandProductListPageState createState() => _BrandProductListPageState();
}

class _BrandProductListPageState extends State<BrandProductListPage> {
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchBrandProducts();
  }

  void _fetchBrandProducts() async {
    final products = await getProductsByBrand(widget.brandName);
    setState(() {
      _products = products;
    });
  }

  Future<void> _deleteProduct(ProductModel product) async {
    // Implement your delete logic here
    await deleteProduct(product); // Replace with your actual delete function
    _fetchBrandProducts(); // Refresh the product list
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
        title: Text('Products by ${widget.brandName}'),
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
