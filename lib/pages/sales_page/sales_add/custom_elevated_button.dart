import 'package:flutter/material.dart';
import 'package:project/pages/color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback addProduct;
  const CustomButton({
    Key? key,
    required this.addProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: addProduct,
      style: ElevatedButton.styleFrom(
          backgroundColor: CustomeColors.Primary,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
      child: const Text(
        'Add Product',
        style: TextStyle(
          fontSize: 16, // Text size
          fontWeight: FontWeight.w500, // Semi-bold text
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
