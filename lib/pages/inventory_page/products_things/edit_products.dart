
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/pages/color.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _colorController;
  late TextEditingController _descriptionController;

  String? _selectedCategory;
  String? _selectedBrand;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _quantityController =
        TextEditingController(text: widget.product.quantity.toString());
    _colorController = TextEditingController(text: widget.product.color);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _selectedCategory = widget.product.categoryId;
    _selectedBrand = widget.product.brand;
    _imageFile = widget.product.imagePath != null
        ? XFile(widget.product.imagePath!)
        : null;
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = pickedFile);
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = ProductModel(
        id: widget.product.id,
        name: _nameController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        color: _colorController.text,
        categoryId: _selectedCategory!,
        brand: _selectedBrand!,
        imagePath: _imageFile?.path ?? widget.product.imagePath,
        description: _descriptionController.text,
      );

      await addOrUpdateProduct(updatedProduct);
      Navigator.pop(context, updatedProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomeColors.Primary,
        title: const Text('Edit Product',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.save),
        //     onPressed: _saveChanges,
        //   ),
        // ],
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
                _buildTextFormField(
                    _nameController, 'Product Name', Icons.shopping_bag),
                _buildTextFormField(_priceController, 'Price',
                    Icons.attach_money, TextInputType.number),
                _buildTextFormField(_quantityController, 'Quantity',
                    Icons.inventory, TextInputType.number),
                _buildTextFormField(
                    _colorController, 'Color', Icons.color_lens),
                _buildTextFormField(_descriptionController, 'Description',
                    Icons.description_sharp),
                // Assuming dropdowns for category and brand are handled similarly
                // Add dropdown fields for category and brand here
                SizedBox(height: 24),
                ElevatedButton(
                  
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomeColors.Primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save Changes',
                      style: TextStyle(fontSize: 18,color: Colors.white)),
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

  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        keyboardType: keyboardType,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter $label' : null,
      ),
    );
  }
}
