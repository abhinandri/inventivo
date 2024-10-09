
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project/model_classes/brandmodel.dart';

class AddBrandScreen extends StatefulWidget {
  final BrandModel? initialBrand;

  AddBrandScreen({this.initialBrand});

  @override
  _AddBrandScreenState createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final TextEditingController _brandController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.initialBrand != null) {
      _brandController.text = widget.initialBrand!.name;
      _selectedImage = XFile(widget.initialBrand!.imagePath!);
    }
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _submit() {
    if (_brandController.text.isNotEmpty && _selectedImage != null) {
      Navigator.of(context).pop(
        BrandModel(
          name: _brandController.text,
          imagePath: _selectedImage!.path,
          id: '',  // You might want to generate an ID here, like using UUID
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields and select an image.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.initialBrand == null ? 'Add Brand' : 'Edit Brand',style: TextStyle(color:Colors.white),),
        backgroundColor: Color(0xFF17A2B8),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Brand Name',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _brandController,
              decoration: InputDecoration(
                hintText: 'Enter brand name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Brand Image',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 8.0),
            _selectedImage == null
                ? GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey, width: 1.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.photo,
                          color: Colors.grey[600],
                          size: 40.0,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          File(_selectedImage!.path),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Change Photo'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue, backgroundColor: Colors.blue[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              child: Text(
                widget.initialBrand == null ? 'Add Brand' : 'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF17A2B8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
