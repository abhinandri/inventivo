import 'package:flutter/material.dart';

Widget buildTextFormField(
    TextEditingController controller, String label, IconData icon,
    [TextInputType keyboardType = TextInputType.text, VoidCallback? onTap]) {
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
      onTap: onTap,
      readOnly: onTap != null,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please enter $label' : null,
    ),
  );
}
