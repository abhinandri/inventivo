
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:project/model_classes/productModel.dart';
// // import 'package:project/db_function/product_function.dart';
// // import 'package:project/pages/inventory_page/products_details_page.dart';

// // class ProductListingPage extends StatefulWidget {
// //   @override
// //   _ProductListingPageState createState() => _ProductListingPageState();
// // }

// // class _ProductListingPageState extends State<ProductListingPage> {
// //   List<ProductModel> _products = [];
// //   List<ProductModel> _filteredProducts = [];

// //   TextEditingController _searchController = TextEditingController();

// //   // Price filter checkboxes
// //   bool _under15000 = false;
// //   bool _between15000and30000 = false;
// //   bool _between30000and60000 = false;
// //   bool _above60000 = false;

// //   // Color filter checkboxes
// //   bool _black = false;
// //   bool _blue = false;
// //   bool _red = false;
// //   bool _green = false;
// //   bool _white = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchProducts();
// //     _searchController.addListener(_filterProducts);
// //   }

// //   void fetchProducts() async {
// //     final products = await getAllProducts();
// //     setState(() {
// //       _products = products;
// //       _filteredProducts = products; // Initially, all products are shown
// //     });
// //   }

// //   void _filterProducts() {
// //     final query = _searchController.text.toLowerCase();

// //     setState(() {
// //       _filteredProducts = _products.where((product) {
// //         final matchesName = product.name.toLowerCase().contains(query);
// //         final matchesPrice = _filterByPrice(product.price);
// //         final matchesColor = _filterByColor(product.color);

// //         return matchesName && matchesPrice && matchesColor;
// //       }).toList();
// //     });
// //   }

// //   bool _filterByPrice(double price) {
// //     if (_under15000 && price < 15000) return true;
// //     if (_between15000and30000 && price >= 15000 && price <= 30000) return true;
// //     if (_between30000and60000 && price >= 30000 && price <= 60000) return true;
// //     if (_above60000 && price > 60000) return true;
// //     return !_under15000 &&
// //         !_between15000and30000 &&
// //         !_between30000and60000 &&
// //         !_above60000;
// //   }

// //   bool _filterByColor(String color) {
// //     if (_black && color.toLowerCase() == "black") return true;
// //     if (_blue && color.toLowerCase() == "blue") return true;
// //     if (_red && color.toLowerCase() == "red") return true;
// //     if (_green && color.toLowerCase() == "green") return true;
// //     if (_white && color.toLowerCase() == "white") return true;
// //     return !_black && !_blue && !_red && !_green && !_white;
// //   }

// //   void _openFilterDialog() {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (context) {
// //         return StatefulBuilder(
// //           builder: (BuildContext context, StateSetter setState) {
          
// //             return SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text('Filter Options',
// //                         style:
// //                             TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //                     SizedBox(height: 10),
              
// //                     // Price filters
// //                     ExpansionTile(
// //                       title: Text('Price'),
// //                       children: [
// //                         CheckboxListTile(
// //                           title: Text('Under ₹15,000'),
// //                           value: _under15000,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _under15000 = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('₹15,000 - ₹30,000'),
// //                           value: _between15000and30000,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _between15000and30000 = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('₹30,000 - ₹60,000'),
// //                           value: _between30000and60000,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _between30000and60000 = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('Above ₹60,000'),
// //                           value: _above60000,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _above60000 = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                       ],
// //                     ),
              
// //                     // Color filters
// //                     ExpansionTile(
// //                       title: Text('Color'),
// //                       children: [
// //                         CheckboxListTile(
// //                           title: Text('Black'),
// //                           value: _black,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _black = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('Blue'),
// //                           value: _blue,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _blue = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('Red'),
// //                           value: _red,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _red = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('Green'),
// //                           value: _green,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _green = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                         CheckboxListTile(
// //                           title: Text('White'),
// //                           value: _white,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               _white = value ?? false;
// //                             });
// //                           },
// //                         ),
// //                       ],
// //                     ),
              
// //                     // Apply/Cancel buttons
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         TextButton(
// //                           onPressed: () {
// //                             Navigator.pop(context); // Close the modal
// //                           },
// //                           child: Text('Cancel'),
// //                         ),
// //                         ElevatedButton(
// //                           onPressed: () {
// //                             Navigator.pop(
// //                                 context); // Close the modal and apply the filters
// //                             _filterProducts();
// //                           },
// //                           child: Text('Apply'),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('All Products'),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.filter_list),
// //             onPressed: _openFilterDialog, // Open filter dialog
// //           ),
// //         ],
// //         bottom: PreferredSize(
// //           preferredSize: Size.fromHeight(50.0),
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Search by name...',
// //                 prefixIcon: Icon(Icons.search),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: _filteredProducts.isEmpty
// //           ? Center(
// //               child: Text(
// //                   'No products found.')) // Show message when no products match
// //           : ListView.builder(
// //               itemCount: _filteredProducts.length,
// //               itemBuilder: (context, index) {
// //                 final product = _filteredProducts[index];
// //                 return ListTile(
// //                   leading: product.imagePath != null &&
// //                           File(product.imagePath!).existsSync()
// //                       ? Image.file(
// //                           File(product.imagePath!),
// //                           width: 50,
// //                           height: 50,
// //                           fit: BoxFit.cover,
// //                         )
// //                       : Icon(Icons.shopping_bag),
// //                   title: Text(product.name),
// //                   subtitle: Text(
// //                       'Price: ₹${product.price} | Color: ${product.color}'),
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => ProductDetailsPage(
// //                           product: product,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:project/model_classes/productModel.dart';
// import 'package:project/db_function/product_function.dart';
// import 'package:project/pages/inventory_page/products_details_page.dart';

// class ProductListingPage extends StatefulWidget {
//   @override
//   _ProductListingPageState createState() => _ProductListingPageState();
// }

// class _ProductListingPageState extends State<ProductListingPage> {
//   List<ProductModel> _products = [];
//   List<ProductModel> _filteredProducts = [];

//   TextEditingController _searchController = TextEditingController();

//   // Price filter checkboxes
//   bool _under15000 = false;
//   bool _between15000and30000 = false;
//   bool _between30000and60000 = false;
//   bool _above60000 = false;

//   // Color filter checkboxes
//   bool _black = false;
//   bool _blue = false;
//   bool _red = false;
//   bool _green = false;
//   bool _white = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//     _searchController.addListener(_filterProducts);
//   }

//   void fetchProducts() async {
//     final products = await getAllProducts();
//     setState(() {
//       _products = products;
//       _filteredProducts = products;
//     });
//   }

//   void _filterProducts() {
//     final query = _searchController.text.toLowerCase();

//     setState(() {
//       _filteredProducts = _products.where((product) {
//         final matchesName = product.name.toLowerCase().contains(query);
//         final matchesPrice = _filterByPrice(product.price);
//         final matchesColor = _filterByColor(product.color);

//         return matchesName && matchesPrice && matchesColor;
//       }).toList();
//     });
//   }

//   bool _filterByPrice(double price) {
//     if (_under15000 && price < 15000) return true;
//     if (_between15000and30000 && price >= 15000 && price <= 30000) return true;
//     if (_between30000and60000 && price >= 30000 && price <= 60000) return true;
//     if (_above60000 && price > 60000) return true;
//     return !_under15000 &&
//         !_between15000and30000 &&
//         !_between30000and60000 &&
//         !_above60000;
//   }

//   bool _filterByColor(String color) {
//     if (_black && color.toLowerCase() == "black") return true;
//     if (_blue && color.toLowerCase() == "blue") return true;
//     if (_red && color.toLowerCase() == "red") return true;
//     if (_green && color.toLowerCase() == "green") return true;
//     if (_white && color.toLowerCase() == "white") return true;
//     return !_black && !_blue && !_red && !_green && !_white;
//   }

//   void _openFilterDialog() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return DraggableScrollableSheet(
//               initialChildSize: 0.6,
//               minChildSize: 0.2,
//               maxChildSize: 0.9,
//               expand: false,
//               builder: (_, controller) {
//                 return SingleChildScrollView(
//                   controller: controller,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Container(
//                             width: 40,
//                             height: 5,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(2.5),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Text('Filter Options',
//                             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 20),
                        
//                         // Price filters
//                         _buildFilterSection(
//                           'Price',
//                           [
//                             _buildCheckbox('Under ₹15,000', _under15000, (value) => setState(() => _under15000 = value ?? false)),
//                             _buildCheckbox('₹15,000 - ₹30,000', _between15000and30000, (value) => setState(() => _between15000and30000 = value ?? false)),
//                             _buildCheckbox('₹30,000 - ₹60,000', _between30000and60000, (value) => setState(() => _between30000and60000 = value ?? false)),
//                             _buildCheckbox('Above ₹60,000', _above60000, (value) => setState(() => _above60000 = value ?? false)),
//                           ],
//                         ),
                        
//                         // Color filters
//                         _buildFilterSection(
//                           'Color',
//                           [
//                             _buildCheckbox('Black', _black, (value) => setState(() => _black = value ?? false)),
//                             _buildCheckbox('Blue', _blue, (value) => setState(() => _blue = value ?? false)),
//                             _buildCheckbox('Red', _red, (value) => setState(() => _red = value ?? false)),
//                             _buildCheckbox('Green', _green, (value) => setState(() => _green = value ?? false)),
//                             _buildCheckbox('White', _white, (value) => setState(() => _white = value ?? false)),
//                           ],
//                         ),
                        
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Cancel'),
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 _filterProducts();
//                               },
//                               child: Text('Apply Filters'),
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildFilterSection(String title, List<Widget> children) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10),
//         ...children,
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
//     return CheckboxListTile(
//       title: Text(title),
//       value: value,
//       onChanged: onChanged,
//       dense: true,
//       contentPadding: EdgeInsets.zero,
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Products'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: _openFilterDialog,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by name...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//           ),
//           Expanded(
//             child: _filteredProducts.isEmpty
//                 ? Center(child: Text('No products found.', style: TextStyle(fontSize: 18)))
//                 : GridView.builder(
//                     padding: EdgeInsets.all(16),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.75,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemCount: _filteredProducts.length,
//                     itemBuilder: (context, index) {
//                       final product = _filteredProducts[index];
//                       return _buildProductCard(product);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductCard(ProductModel product) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProductDetailsPage(product: product),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                 child: product.imagePath != null && File(product.imagePath!).existsSync()
//                     ? Image.file(
//                         File(product.imagePath!),
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       )
//                     : Container(
//                         color: Colors.grey[300],
//                         child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey[600]),
//                       ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     '₹${product.price.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 14, color: Colors.green[700], fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     product.color,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/pages/inventory_page/products_details_page.dart';

class ProductListingPage extends StatefulWidget {
  @override
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];

  TextEditingController _searchController = TextEditingController();

  // Price filter checkboxes
  bool _under15000 = false;
  bool _between15000and30000 = false;
  bool _between30000and60000 = false;
  bool _above60000 = false;

  // Color filter checkboxes
  bool _black = false;
  bool _blue = false;
  bool _red = false;
  bool _green = false;
  bool _white = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  void fetchProducts() async {
    final products = await getAllProducts();
    setState(() {
      _products = products;
      _filteredProducts = products;
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredProducts = _products.where((product) {
        final matchesName = product.name.toLowerCase().contains(query);
        final matchesPrice = _filterByPrice(product.price);
        final matchesColor = _filterByColor(product.color);

        return matchesName && matchesPrice && matchesColor;
      }).toList();
    });
  }

  bool _filterByPrice(double price) {
    if (_under15000 && price < 15000) return true;
    if (_between15000and30000 && price >= 15000 && price <= 30000) return true;
    if (_between30000and60000 && price >= 30000 && price <= 60000) return true;
    if (_above60000 && price > 60000) return true;
    return !_under15000 &&
        !_between15000and30000 &&
        !_between30000and60000 &&
        !_above60000;
  }

  bool _filterByColor(String color) {
    if (_black && color.toLowerCase() == "black") return true;
    if (_blue && color.toLowerCase() == "blue") return true;
    if (_red && color.toLowerCase() == "red") return true;
    if (_green && color.toLowerCase() == "green") return true;
    if (_white && color.toLowerCase() == "white") return true;
    return !_black && !_blue && !_red && !_green && !_white;
  }

  void _openFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              expand: false,
              builder: (_, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Filter Options',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        
                        // Price filters
                        _buildFilterSection(
                          'Price',
                          [
                            _buildCheckbox('Under ₹15,000', _under15000, (value) => setState(() => _under15000 = value ?? false)),
                            _buildCheckbox('₹15,000 - ₹30,000', _between15000and30000, (value) => setState(() => _between15000and30000 = value ?? false)),
                            _buildCheckbox('₹30,000 - ₹60,000', _between30000and60000, (value) => setState(() => _between30000and60000 = value ?? false)),
                            _buildCheckbox('Above ₹60,000', _above60000, (value) => setState(() => _above60000 = value ?? false)),
                          ],
                        ),
                        
                        // Color filters
                        _buildFilterSection(
                          'Color',
                          [
                            _buildCheckbox('Black', _black, (value) => setState(() => _black = value ?? false)),
                            _buildCheckbox('Blue', _blue, (value) => setState(() => _blue = value ?? false)),
                            _buildCheckbox('Red', _red, (value) => setState(() => _red = value ?? false)),
                            _buildCheckbox('Green', _green, (value) => setState(() => _green = value ?? false)),
                            _buildCheckbox('White', _white, (value) => setState(() => _white = value ?? false)),
                          ],
                        ),
                        
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _filterProducts();
                              },
                              child: Text('Apply Filters'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Color(0xFF17A2B8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...children,
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title,style: TextStyle(fontSize: 16),),
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
      
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF17A2B8),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _openFilterDialog,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: _filteredProducts.isEmpty
          ? Center(child: Text('No products found.', style: TextStyle(fontSize: 18)))
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: product.imagePath != null && File(product.imagePath!).existsSync()
                    ? Image.file(
                        File(product.imagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey[600]),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.green[700], fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.color,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}