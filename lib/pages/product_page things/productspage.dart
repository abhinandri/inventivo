
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:project/db_function/product_function.dart';
// import 'package:project/model_classes/productModel.dart';
// import 'package:project/pages/product_page%20things/add_Product.dart';

// class Products extends StatefulWidget {
//   Products({super.key});

//   @override
//   State<Products> createState() => _ProductsState();
// }

// class _ProductsState extends State<Products> {
//   List<ProductModel> products = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final fetchedItems = await getAllProducts();
//     if (fetchedItems != null) {
//       setState(() {
//         products = fetchedItems;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//         backgroundColor: const Color(0xFF17A2B8),
//         centerTitle: true,
//       ),
//       body: ValueListenableBuilder<List<ProductModel>>(
//         valueListenable: productListNotifier,
//         builder: (context, productList, child) {
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Number of columns
//               crossAxisSpacing: 12.0, // Spacing between columns
//               mainAxisSpacing: 12.0, // Spacing between rows
//               childAspectRatio: 2 / 3, // Adjusted aspect ratio for better fit
//             ),
//             padding: const EdgeInsets.all(16.0), // More padding around the grid
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(12),
//                         ),
//                         child: product.imagePath != null
//                             ? Image.file(
//                                 File(product.imagePath!),
//                                 fit: BoxFit.cover,
//                               )
//                             : const Icon(Icons.image, size: 50),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '\$${product.price.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                           const SizedBox(height: 4.0),
//                           Text(
//                             product.name,
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14.0,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Add edit and delete buttons
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () async {
//                               final updatedProduct = await Navigator.of(context)
//                                   .push<ProductModel>(
//                                 MaterialPageRoute(
//                                   builder: (context) => AddProductScreen(
//                                     categoryId:
//                                         'category', // Replace with actual category ID
//                                     productType:
//                                         '', categories: [], // Replace with actual product type if needed
//                                     // product: product, // Pass the product to edit
//                                   ),
//                                 ),
//                               );
//                               if (updatedProduct != null) {
//                                 updateProduct(updatedProduct);
//                               }
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               _showDeleteConfirmationDialog(context, product);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newProduct = await Navigator.of(context).push<ProductModel>(
//             MaterialPageRoute(
//               builder: (context) => AddProductScreen(
//                 categoryId: 'category',
//                 productType: 'product_type', categories: [],
//               ),
//             ),
//           );
//           if (newProduct != null) {
//             updateProduct(newProduct);
//           }
//         },
//         backgroundColor: const Color(0xFF17A2B8),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> _showDeleteConfirmationDialog(
//       BuildContext context, ProductModel product) async {
//     final shouldDelete = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Deletion'),
//         content: const Text('Are you sure you want to delete this product?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );

//     if (shouldDelete == true) {
//       deleteProduct(product);
//     }
//   }
// }
