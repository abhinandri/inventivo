// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:project/model_classes/productModel.dart';

// class ProductListingPage extends StatefulWidget {
//   final int categoryId;

//   ProductListingPage({required this.categoryId});

//   @override
//   _ProductListingPageState createState() => _ProductListingPageState();
// }

// class _ProductListingPageState extends State<ProductListingPage> {
//   List<ProductModel> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final box = await Hive.openBox<ProductModel>('products'); 
//     setState(() {
//       products = box.values.where((product) => product.categoryId == widget.categoryId).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Listing'),
//         backgroundColor: const Color(0xFF17A2B8),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//             leading: product.imagePath != null
//                 ? Image.file(
//                     File(product.imagePath!),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   )
//                 : const Icon(Icons.image, size: 50),
//           );
//         },
//       ),
//     );
//   }
// }
