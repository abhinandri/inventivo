import 'package:flutter/material.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/inventory_page/all_products_list.dart';
import 'package:project/pages/inventory_page/brands_list.dart';
import 'package:project/pages/inventory_page/category_list.dart';
import 'package:project/pages/product_page%20things/brand_gride.dart';
import 'package:project/pages/product_page%20things/build_header.dart';
import 'package:project/pages/product_page%20things/category_gride.dart';

class invent_sliver extends StatelessWidget {
  const invent_sliver({
    super.key,
    required List<CategoryModel> categories,
    required List<BrandModel> brands,
  }) : _categories = categories, _brands = brands;

  final List<CategoryModel> _categories;
  final List<BrandModel> _brands;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
    
              GestureDetector(
                onTap: () {
                  // Navigate to the product list page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListingPage(),
                    ),
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Search Products...',
                      hintStyle: TextStyle(
                        color:
                            Colors.grey[600], // Hint text color
                        fontSize: 16, // Adjust hint text size
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.teal, // Icon color
                        size: 28, // Icon size
                      ),
                      filled: true,
                      fillColor: Colors.grey[
                          200], // Background color of the search bar
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal:
                              20), // Padding inside the TextField
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide
                            .none, // Removes border for a cleaner look
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors
                              .teal, // Border color when the field is focused
                          width:
                              2, // Thickness of the border when focused
                        ),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 16), // Adjust the text size
                  ),
                ),
              ),
    
              build_sectionHeader(title: 'Categories', onSeeAllPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CategoryListingPage()),
                )),
              // const SizedBox(height: 10),
              category_gride(categories: _categories),
              // const SizedBox(height: 2),
              build_sectionHeader(title: 'Brands', onSeeAllPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BrandListingPage()),
                )),
              brand_gride(brands: _brands)
            ],
          ),
        )
      ],
    );
  }
}