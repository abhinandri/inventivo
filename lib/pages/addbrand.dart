
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddBrand extends StatefulWidget {
//   @override
//   _AddBrandState createState() => _AddBrandState();
// }

// class _AddBrandState extends State<AddBrand> {
//   final TextEditingController _brandController = TextEditingController();
//   XFile? _selectedImage;

//   void _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _selectedImage = image;
//     });
//   }

//   void _submit() {
//     if (_brandController.text.isNotEmpty && _selectedImage != null) {
//       Navigator.of(context).pop({
//         'name': _brandController.text,
//         'image': _selectedImage,
//       });
//     } else {
//       // Show an error if fields are empty
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: const Text('Please fill in all fields and select an image.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Brand'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF17A2B8),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text(
//               'Brand Name',
//               style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//             ),
//             const SizedBox(height: 8.0),
//             TextField(
//               controller: _brandController,
//               decoration: InputDecoration(
//                 hintText: 'Enter brand name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               ),
//             ),
//             const SizedBox(height: 24.0),
//             Text(
//               'Brand Image',
//               style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//             ),
//             const SizedBox(height: 8.0),
//             Center(
//               child: GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 150.0,
//                   width: 150.0,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(12.0),
//                     image: _selectedImage != null
//                         ? DecorationImage(
//                             image: FileImage(File(_selectedImage!.path)),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child: _selectedImage == null
//                       ? const Center(
//                           child: Text(
//                             'Tap to select image',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             if (_selectedImage != null)
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: _pickImage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF17A2B8),
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   icon: const Icon(Icons.edit),
//                   label: const Text('Change Image'),
//                 ),
//               ),
//             const SizedBox(height: 24.0),
//             ElevatedButton(
//               onPressed: _submit,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF17A2B8),
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//               child: const Text(
//                 'Add Brand',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
