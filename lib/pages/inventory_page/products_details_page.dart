
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:project/model_classes/productModel.dart';
// import 'package:project/pages/color.dart';
// import 'package:project/pages/inventory_page/products_things/edit_products.dart';

// class ProductDetailsPage extends StatefulWidget {
//   final ProductModel product;

//   const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   late ProductModel _product;

//   @override
//   void initState() {
//     super.initState();
//     _product = widget.product;
//   }

//   void _navigateToEditPage() async {
//     final updatedProduct = await Navigator.push<ProductModel>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProductPage(product: _product),
//       ),
//     );

//     if (updatedProduct != null) {
//       setState(() {
//         _product = updatedProduct;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: CustomeColors.Primary,
//         title: Text('Product Details',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: _navigateToEditPage,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProductImage(),
//             _buildProductDetails(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductImage() {
//     return Container(
//       height: 200,
//       width: double.infinity,
//       color: Colors.grey[200],
//       child: _product.imagePath != null && File(_product.imagePath!).existsSync()
//           ? Image.file(
//               File(_product.imagePath!),
//               fit: BoxFit.contain,
//             )
//           : Icon(Icons.inventory_2, size: 80, color: Colors.grey[400]),
//     );
//   }

//   Widget _buildProductDetails() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _product.name,
//             style: Theme.of(context).textTheme.headline5?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           SizedBox(height: 16),
//           _buildDetailCard(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailCard() {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildDetailRow('Category', _product.categoryId),
//             _buildDetailRow('Brand', _product.brand),
//             _buildDetailRow('Price', '\₹${_product.price.toStringAsFixed(2)}'),
//             _buildDetailRow('Quantity', _product.quantity.toString()),
//             _buildDetailRow('Color', _product.color),
//             _buildDetailRow('Descrption',_product.description.toString())
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/pages/color.dart';
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
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildProductDetails(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToEditPage,
        child: Icon(Icons.edit, color: Colors.white),
        backgroundColor: CustomeColors.Primary,
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: _buildProductImage(),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _product.imagePath != null
            ? Image.file(File(_product.imagePath!), fit: BoxFit.cover)
            : Container(color: Colors.grey[200]),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: Text(
            _product.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceTag(),
          _buildDetailCard(),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildPriceTag() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\₹${_product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'In Stock',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow('Brand', _product.brand),
            _buildDetailRow('Category', _product.categoryId),
            _buildDetailRow('Quantity', _product.quantity.toString()),
            _buildDetailRow('Color', _product.color),
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
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _product.description ?? 'No description available.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}