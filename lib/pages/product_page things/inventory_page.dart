import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/db_function/brand_function.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/AddCategoryScreen.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/pages/inventory_page/products_details_page.dart';
import 'package:project/pages/product_page%20things/add_brand_page.dart';
import 'package:project/pages/product_page%20things/add_product_screen.dart';
import 'package:project/pages/product_page%20things/custome_sliver_appbar.dart';

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

  Widget _buildProductsList() {
    return ValueListenableBuilder<List<ProductModel>>(
      valueListenable: productListNotifier,
      builder: (context, products, child) {
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
              child: Container(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        leading: product.imagePath != null &&
                                File(product.imagePath!).existsSync()
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
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
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 2),
                            Text(
                              'Qty: ${product.quantity}', // Display product quantity
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            // const SizedBox(height: 4),
                            Text(
                              'Price: \₹${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green),
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
                        onLongPress: () {
                          _showDeleteConfirmationDialog(context, product);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete "${product.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteProduct(product);
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
      body: CustomScrollView(
        slivers: [
          CustomeSliverAppBar(categories: _categories, brands: _brands),
          SliverFillRemaining(
            child: Column(
              children: [
                const SizedBox(
                  height: 13,
                ),
                Expanded(child: _buildProductsList())
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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






