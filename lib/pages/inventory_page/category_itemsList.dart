
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:project/model_classes/productModel.dart';
// import 'package:project/db_function/product_function.dart';
// import 'package:project/pages/inventory_page/products_details_page.dart';

// class CategoryProductListPage extends StatefulWidget {
//   final String categoryName;

//   CategoryProductListPage({required this.categoryName});

//   @override
//   _CategoryProductListPageState createState() => _CategoryProductListPageState();
// }

// class _CategoryProductListPageState extends State<CategoryProductListPage> {
//   List<ProductModel> _products = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCategoryProducts();
//   }

//   void _fetchCategoryProducts() async {
//     final products = await getProductsByCategory(widget.categoryName);
//     setState(() {
//       _products = products;
//     });
//   }

//   Future<void> _deleteProduct(ProductModel product) async {
//     // Implement your delete logic here
//     await deleteProduct(product); // Replace with your actual delete function
//     _fetchCategoryProducts(); // Refresh the product list
//   }

//   void _showDeleteConfirmationDialog(ProductModel product) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete ${product.name}?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _deleteProduct(product);
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products in ${widget.categoryName}'),
//       ),
//       body: ListView.builder(
//         itemCount: _products.length,
//         itemBuilder: (context, index) {
//           final product = _products[index];
//           return ListTile(
//             leading: product.imagePath != null && File(product.imagePath!).existsSync()
//                 ? Image.file(
//                     File(product.imagePath!),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   )
//                 : Icon(Icons.shopping_bag),
//             title: Text(product.name),
//             subtitle: Text('Price: ${product.price}'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailsPage(product: product),
//                 ),
//               );
//             },
//             onLongPress: () {
//               _showDeleteConfirmationDialog(product);
//             },
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
import 'package:project/pages/color.dart';
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
    await deleteProduct(product);
    _fetchCategoryProducts();
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(product);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
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
        backgroundColor: CustomeColors.Primary,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('Products in ${widget.categoryName}',style: TextStyle(color: Colors.white),),
        elevation: 0,
      ),
      body: _products.isEmpty
          ? Center(child: Text('No products found in this category.'))
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return _buildProductCard(product);
              },
            ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        ),
        onLongPress: () => _showDeleteConfirmationDialog(product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: _buildProductImage(product),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(ProductModel product) {
    if (product.imagePath != null && File(product.imagePath!).existsSync()) {
      return Image.file(
        File(product.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      return Container(
        color: Colors.grey[200],
        child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey[400]),
      );
    }
  }
}