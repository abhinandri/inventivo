import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/db_function/brand_function.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/AddCategoryScreen.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/inventory_page/all_products_list.dart';
import 'package:project/pages/inventory_page/brand_item_list.dart';
import 'package:project/pages/inventory_page/brands_list.dart';
import 'package:project/pages/inventory_page/category_itemsList.dart';
import 'package:project/pages/inventory_page/category_list.dart';
import 'package:project/pages/inventory_page/products_details_page.dart';
import 'package:project/pages/product_page%20things/add_brand_page.dart';
import 'package:project/pages/product_page%20things/add_product_screen.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<CategoryModel> _categories = [];
  List<BrandModel> _brands = [];
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    fetchProducts();
    _fetchBrands();
  }

  void _fetchCategories() async {
    final categories = await getAllCatogories();
    setState(() {
      _categories = categories;
    });
  }

  void _addCategory(CategoryModel category) async {
    await addCategory(category);
    _fetchCategories();
  }

  void fetchProducts() async {
    final fetchitem = await getAllProducts();
    setState(() {
      products = fetchitem;
    });
  }

  void _fetchBrands() async {
    final brands = await getAllBrands();
    setState(() {
      _brands = brands;
    });
  }

  void _addBrand(BrandModel brand) async {
    await addBrand(brand);
    _fetchBrands();
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAllPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    List<Widget> gridItems = [];

    if (_categories.isEmpty) {
      gridItems.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Icon(
                  Icons.category,
                  size: 50,
                  color: Colors.grey,
                ),
                Text(
                  'No categories available',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      gridItems = _categories.map((category) {
        return InkWell(
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
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  category.imagePath != null
                      ? Image.file(
                          File(category.imagePath!),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.category),
                  const SizedBox(height: 8),
                  Text(category.name),
                ],
              ),
            ),
          ),
        );
      }).toList();
    }

    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: gridItems,
      ),
    );
  }

  Widget _buildBrandsGrid() {
    List<Widget> gridItems = [];

    if (_brands.isEmpty) {
      gridItems.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.branding_watermark,
                  size: 50,
                  color: Colors.grey,
                ),
                SizedBox(height: 8),
                Text(
                  'No brands available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      gridItems = _brands.map((brand) {
        return InkWell(
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
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  brand.imagePath != null && File(brand.imagePath!).existsSync()
                      ? Image.file(
                          File(brand.imagePath!),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.branding_watermark),
                  const SizedBox(height: 8),
                  Text(brand.name),
                ],
              ),
            ),
          ),
        );
      }).toList();
    }

    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: gridItems,
      ),
    );
  }

  Widget _buildProductsList() {
    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No products available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(
        //   height: 20,
        // ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20.0,
          ),
          child: Text(
            'Products',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(
            // parent: NeverScrollableScrollPhysics()
            // ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: product.imagePath != null &&
                          File(product.imagePath!).existsSync()
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(product.imagePath!),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'Quantity: ${product.quantity}', // Display product quantity
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: CustomeColors.Primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
            ),
            expandedHeight: 480,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Inventivo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              background: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
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

                            _buildSectionHeader(
                              'Categories',
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryListingPage()),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            _buildCategoriesGrid(),
                            const SizedBox(height: 10),
                            _buildSectionHeader(
                              'Brands',
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BrandListingPage()),
                              ),
                            ),

                            _buildBrandsGrid()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Expanded(child: _buildProductsList())
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF17A2B8),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            color: Color(0xFF17A2B8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.category, color: Colors.white),
                title: const Text('Add Category',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCategoryScreen(),
                    ),
                  );
                  if (result is CategoryModel) {
                    _addCategory(result);
                  }
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.branding_watermark, color: Colors.white),
                title: const Text('Add Brand',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBrandScreen(),
                    ),
                  );
                  if (result is BrandModel) {
                    _addBrand(result);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text('Add Product',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProductScreen(),
                    ),
                  );
                  if (result is ProductModel) {
                    fetchProducts();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
