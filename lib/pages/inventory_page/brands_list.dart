// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:project/model_classes/brandmodel.dart';
// import 'package:project/db_function/brand_function.dart';
// import 'package:project/pages/inventory_page/brand_item_list.dart';

// class BrandListingPage extends StatefulWidget {
//   @override
//   _BrandListingPageState createState() => _BrandListingPageState();
// }

// class _BrandListingPageState extends State<BrandListingPage> {
//   List<BrandModel> _brands = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBrands();
//   }

//   void _fetchBrands() async {
//     final brands = await getAllBrands();
//     setState(() {
//       _brands = brands;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Brands'),
//       ),
//       body: ListView.builder(
//         itemCount: _brands.length,
//         itemBuilder: (context, index) {
//           final brand = _brands[index];
//           return ListTile(
//             leading: brand.imagePath != null && File(brand.imagePath!).existsSync()
//                 ? Image.file(
//                     File(brand.imagePath!),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   )
//                 : Icon(Icons.branding_watermark),
//             title: Text(brand.name),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BrandProductListPage(
//                     brandName: brand.name,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/db_function/brand_function.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/inventory_page/brand_item_list.dart';

class BrandListingPage extends StatefulWidget {
  @override
  _BrandListingPageState createState() => _BrandListingPageState();
}

class _BrandListingPageState extends State<BrandListingPage> {
  List<BrandModel> _brands = [];

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  void _fetchBrands() async {
    final brands = await getAllBrands();
    setState(() {
      _brands = brands;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor:CustomeColors.Primary,
        title: Text('All Brands',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:_brands.isEmpty? Center(
              child: Text(
                "No brands available.",
                style: TextStyle(
                  fontSize: 14,
                  
                  color: Colors.black,
                ),
              ),
            ):
            GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
          childAspectRatio: 1.0, // Aspect ratio for each grid item
        ),
        itemCount: _brands.length,
        itemBuilder: (context, index) {
          final brand = _brands[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrandProductListPage(
                    brandName: brand.name,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: brand.imagePath != null && File(brand.imagePath!).existsSync()
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.file(
                              File(brand.imagePath!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.branding_watermark,
                            size: 50,
                            color: Colors.grey,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      brand.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
