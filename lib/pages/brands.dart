
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:project/model_classes/usermodel.dart';
// import 'package:project/pages/addbrand.dart';
// import 'dart:io';

// class BrandScreen extends StatefulWidget {
//   @override
//   _BrandScreenState createState() => _BrandScreenState();
// }

// class _BrandScreenState extends State<BrandScreen> {
//   List<BrandModel> _filteredBrands = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_filterBrands);
//     _fetchBrands();
//   }

//   void _fetchBrands() async {
//     final brandBox = await Hive.openBox<BrandModel>('brands');
//     setState(() {
//       _filteredBrands = brandBox.values.toList();
//     });
//   }

//   void _saveBrand(BrandModel brand) async {
//     final brandBox = await Hive.openBox<BrandModel>('brands');
//     brandBox.add(brand);
//     _fetchBrands(); // Refresh the brand list
//   }

//   void _filterBrands() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredBrands = _filteredBrands
//           .where((brand) => brand.name.toLowerCase().contains(query))
//           .toList();
//     });
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
//         automaticallyImplyLeading: false,
//         title: const Text('Brands'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF17A2B8),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(56.0),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 4.0,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   hintText: 'Search brands...',
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.white,
//                 Colors.white,
//                 Color.fromARGB(255, 129, 240, 255),
//               ],
//             ),
//           ),
//           child: GridView.builder(
//             padding: const EdgeInsets.all(16.0),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 16.0,
//               mainAxisSpacing: 16.0,
//             ),
//             itemCount: _filteredBrands.length,
//             itemBuilder: (context, index) {
//               final brand = _filteredBrands[index];
//               return Card(
//                 elevation: 6.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Stack(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // Handle item tap
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           brand.imagePath != null
//                               ? ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: Image.file(
//                                     File(brand.imagePath!),
//                                     height: 100,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )
//                               : const Icon(Icons.image, size: 100, color: Colors.grey),
//                           const SizedBox(height: 8),
//                           Text(
//                             brand.name,
//                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       right: 8.0,
//                       top: 8.0,
//                       child: IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           // Handle delete action
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddBrand()),
//           );
//           if (result != null) {
//             final newBrand = BrandModel(
//               id: DateTime.now().toIso8601String(),
//               name: result['name'],
//               categoryId: 'categoryId', // Replace with actual categoryId
//               imagePath: result['image'].path,
//             );
//             _saveBrand(newBrand);
//           }
//         },
//         backgroundColor: const Color(0xFF17A2B8),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
