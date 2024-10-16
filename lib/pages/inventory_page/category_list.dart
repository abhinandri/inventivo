
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/inventory_page/category_itemsList.dart';

class CategoryListingPage extends StatefulWidget {
  @override
  _CategoryListingPageState createState() => _CategoryListingPageState();
}

class _CategoryListingPageState extends State<CategoryListingPage> {
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final categories = await getAllCatogories();
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomeColors.Primary,
        title: Text('All Categories',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:_categories.isEmpty? Center(
              child: Text(
               "No categories found."
,
                style: TextStyle(
                  fontSize: 14,
                  
                  color: Colors.black,
                ),
              ),
            ): 
      
      GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
          childAspectRatio: 1.0, // Ratio of width to height for each grid item
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductListPage(
                    categoryName: category.name,
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
                    child: category.imagePath != null && File(category.imagePath!).existsSync()
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.file(
                              File(category.imagePath!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.category,
                            size: 50,
                            color: Colors.grey,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category.name,
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
