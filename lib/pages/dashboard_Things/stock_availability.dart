// // // import 'package:flutter/material.dart';

// // // class StockAvailabilityPage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Dummy stock data (you can fetch this from your database or API)
// // //     final outOfStockProducts = ['Product A', 'Product B'];
// // //     final lowStockProducts = ['Product C', 'Product D'];
// // //     final mostAvailableProducts = ['Product E', 'Product F'];

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Stock Availability'),
// // //         centerTitle: true,
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text(
// // //               'Out of Stock',
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             SizedBox(height: 8),
// // //             _buildProductList(outOfStockProducts),
// // //             SizedBox(height: 16),
// // //             Text(
// // //               'Low Stock',
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             SizedBox(height: 8),
// // //             _buildProductList(lowStockProducts),
// // //             SizedBox(height: 16),
// // //             Text(
// // //               'Most Available Products',
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             SizedBox(height: 8),
// // //             _buildProductList(mostAvailableProducts),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // Helper method to display the list of products
// // //   Widget _buildProductList(List<String> products) {
// // //     return Column(
// // //       children: products.map((product) {
// // //         return ListTile(
// // //           title: Text(product),
// // //         );
// // //       }).toList(),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:hive/hive.dart';
// // import 'package:project/model_classes/productModel.dart'; // Ensure this imports your ProductModel

// // class StockAvailabilityPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Stock Availability'),
// //         centerTitle: true,
// //       ),
// //       body: FutureBuilder<List<ProductModel>>(
// //         future: _fetchProducts(), // Fetch products from Hive
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator()); // Show loading indicator
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}')); // Show error message
// //           } else {
// //             final products = snapshot.data ?? [];
// //             final outOfStockProducts = products.where((product) => product.quantity == 0).toList();
// //             final lowStockProducts = products.where((product) => product.quantity < 3 && product.quantity > 0).toList();
// //             final mostAvailableProducts = products.where((product) => product.quantity >= 3).toList();

// //             return Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Out of Stock',
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 8),
// //                   _buildProductList(outOfStockProducts),
// //                   SizedBox(height: 16),
// //                   Text(
// //                     'Low Stock',
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 8),
// //                   _buildProductList(lowStockProducts),
// //                   SizedBox(height: 16),
// //                   Text(
// //                     'Most Available Products',
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 8),
// //                   _buildProductList(mostAvailableProducts),
// //                 ],
// //               ),
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   // Fetch all products from Hive
// //   Future<List<ProductModel>> _fetchProducts() async {
// //     final box = await Hive.openBox<ProductModel>('products');
// //     return box.values.toList();
// //   }

// //   // Helper method to display the list of products
// //   Widget _buildProductList(List<ProductModel> products) {
// //     if (products.isEmpty) {
// //       return Text('No products available'); // Show a message if no products
// //     }
// //     return Column(
// //       children: products.map((product) {
// //         return ListTile(
// //           title: Text(product.name), // Display the product name
// //         );
// //       }).toList(),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:project/model_classes/productModel.dart';

// class StockAvailabilityPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stock Availability'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: FutureBuilder<List<ProductModel>>(
//         future: _fetchProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final products = snapshot.data ?? [];
//             final outOfStockProducts = products.where((product) => product.quantity == 0).toList();
//             final lowStockProducts = products.where((product) => product.quantity < 3 && product.quantity > 0).toList();
//             final mostAvailableProducts = products.where((product) => product.quantity >= 3).toList();

//             return ListView(
//               padding: const EdgeInsets.all(16.0),
//               children: [
//                 _buildStockSection('Out of Stock', outOfStockProducts, Colors.red),
//                 SizedBox(height: 16),
//                 _buildStockSection('Low Stock', lowStockProducts, Colors.orange),
//                 SizedBox(height: 16),
//                 _buildStockSection('Most Available', mostAvailableProducts, Colors.green),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<List<ProductModel>> _fetchProducts() async {
//     final box = await Hive.openBox<ProductModel>('products');
//     return box.values.toList();
//   }

//   Widget _buildStockSection(String title, List<ProductModel> products, Color color) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Text(
//               title,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//           if (products.isEmpty)
//             Padding(
//               padding: EdgeInsets.all(12),
//               child: Text('No products available'),
//             )
//           else
//             ListView.separated(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: products.length,
//               separatorBuilder: (context, index) => Divider(height: 1),
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text('Quantity: ${product.quantity}'),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     // TODO: Implement product detail view
//                   },
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project/pages/color.dart';

class StockAvailabilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Availability',style: TextStyle(color:Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: CustomeColors.Primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data ?? [];
            final outOfStockProducts = products.where((product) => product.quantity == 0).toList();
            final lowStockProducts = products.where((product) => product.quantity < 3 && product.quantity > 0).toList();
            final mostAvailableProducts = products.where((product) => product.quantity >= 3).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    // child: Text(
                    //   'Stock Overview',
                    //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    // ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildStockSummary(products),
                ),
                _buildStockSection('Out of Stock', outOfStockProducts, Colors.red.shade400),
                _buildStockSection('Low Stock', lowStockProducts, Colors.orange.shade500),
                _buildStockSection('Well Stocked', mostAvailableProducts, Colors.green.shade500),
              ],
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.refresh),
      //   onPressed: () {
      //     // TODO: Implement refresh functionality
      //   },
      // ),
    );
  }

  Future<List<ProductModel>> _fetchProducts() async {
    final box = await Hive.openBox<ProductModel>('products');
    return box.values.toList();
  }

  Widget _buildStockSummary(List<ProductModel> products) {
    final totalProducts = products.length;
    final outOfStock = products.where((p) => p.quantity == 0).length;
    final lowStock = products.where((p) => p.quantity < 3 && p.quantity > 0).length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildSummaryItem('Total Products', totalProducts, Colors.blue),
              _buildSummaryItem('Out of Stock', outOfStock, Colors.red),
              _buildSummaryItem('Low Stock', lowStock, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, int value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value.toString(),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockSection(String title, List<ProductModel> products, Color color) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        products.length.toString(),
                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              if (products.isEmpty)
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('No products available'),
                )
              else
                AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              title: Text(product.name),
                              subtitle: Text('Quantity: ${product.quantity}'),
                              // trailing: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                // TODO: Implement product detail view
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}