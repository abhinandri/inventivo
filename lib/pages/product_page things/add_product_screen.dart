import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/db_function/brand_function.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/easy_use.dart';
import 'package:project/pages/product_page%20things/add_product_text.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _colorController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _selectedBrand;
  XFile? _imageFile;

  List<CategoryModel> _categories = [];
  List<BrandModel> _brands = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchBrands();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _colorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    final fetchedItems = await getAllCatogories();
    if (fetchedItems != null) {
      setState(() => _categories = fetchedItems);
    }
  }

  Future<void> _fetchBrands() async {
    final fetchedItems = await getAllBrands();
    if (fetchedItems != null) {
      setState(() => _brands = fetchedItems);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = pickedFile);
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_imageFile == null) {
        _showSnackBar('Please select an image for the product');
        return;
      }

      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        color: _colorController.text,
        categoryId: _selectedCategory!,
        brand: _selectedBrand!,
        imagePath: _imageFile!.path,
        description: _descriptionController.text
      );

      await addOrUpdateProduct(product);
      _showSnackBar('Product added successfully');
      Navigator.pop(context, true);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomeColors.Primary,
        title: const Text('Add New Product',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImagePicker(),
                const SizedBox(height: 24),
                buildTextFormField(
                    _nameController, 'Product Name', Icons.shopping_bag),
                buildTextFormField(_priceController, 'Price',
                    Icons.attach_money, TextInputType.number),
                buildTextFormField(_quantityController, 'Quantity',
                    Icons.inventory, TextInputType.number),
                buildTextFormField(
                    _colorController, 'Color', Icons.color_lens),
                buildTextFormField(_descriptionController, 'Description',Icons.description_sharp,TextInputType.multiline,),
                buildDropdownField(
                    'Category',
                    _categories.map((c) => c.name).toList(),
                    _selectedCategory,
                    (value) => setState(() => _selectedCategory = value),
                    Icons.category),
                buildDropdownField(
                    'Brand',
                    _brands.map((b) => b.name).toList(),
                    _selectedBrand,
                    (value) => setState(() => _selectedBrand = value),
                    Icons.branding_watermark),
                const SizedBox(height: 24),
                ElevatedButton(
                  
                  onPressed: _addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomeColors.Primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      const Text('Add Product', style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: _imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                ),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Tap to add product image',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
      ),
    );
  }

 
}
