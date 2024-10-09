
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/AddCategoryScreen.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoryModel> categories = [];
  List<CategoryModel> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllCategories();
    _searchController.addListener(_filterCategories);
  }

  Future<void> fetchAllCategories() async {
    final List<CategoryModel> fetchedItems = await getAllCatogories();
    setState(() {
      categories = fetchedItems;
      _filteredCategories = fetchedItems;
    });
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = categories
          .where((category) => category.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _addCategory() async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (context) => AddCategoryScreen()),
    );
    if (result != null && result['name'] != null && result['image'] != null) {
      final newCategory = CategoryModel(
        name: result['name'],
        imagePath: result['image'].path,
        id: DateTime.now().millisecond.toString(),
      );
      await addCategory(newCategory);
      fetchAllCategories(); // Refresh the list of categories
    }
  }

  Future<void> _deleteCategory(CategoryModel category) async {
    await deleteCategory(category); // Your method to delete the category
    fetchAllCategories(); // Refresh the list of categories
  }

  Future<void> _editCategory(CategoryModel category) async {
    // Implement editing logic here, similar to adding a new category
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (context) => AddCategoryScreen(
          initialCategory: category,
        ),
      ),
    );
    if (result != null && result['name'] != null && result['image'] != null) {
      final updatedCategory = CategoryModel(
        name: result['name'],
        imagePath: result['image'].path,
        id: category.id,
      );
      await deleteCategory(category); // Delete old category
      await addCategory(updatedCategory); // Add updated category
      fetchAllCategories(); // Refresh the list of categories
    }
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
        automaticallyImplyLeading: false,
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: const Color(0xFF17A2B8),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search categories...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
                Color.fromARGB(255, 129, 240, 255),
              ],
            ),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final category = _filteredCategories[index];
              return Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Products()));
                      // },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          category.imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(category.imagePath!),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image,
                                  size: 100, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(
                            category.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 8.0,
                      top: 8.0,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editCategory(category);
                          } else if (value == 'delete') {
                            _showDeleteConfirmationDialog(category);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        backgroundColor: const Color(0xFF17A2B8),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(CategoryModel category) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete == true) {
      _deleteCategory(category);
    }
  }
}
