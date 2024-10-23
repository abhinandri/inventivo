 import 'package:flutter/material.dart';

// Widget _buildTextFormField(
//       TextEditingController controller, String label, IconData icon,
//       [TextInputType keyboardType = TextInputType.text,int maxLines=1]) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: TextFormField(
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           filled: true,
//           fillColor: Colors.grey[100],
//         ),
//         keyboardType: keyboardType,
      
//         maxLines: maxLines,
//         validator: (value) =>
//             value?.isEmpty ?? true ? 'Please enter $label' : null,
//       ),
//     );
//   }

  Widget buildDropdownField(String label, List<String> items, String? value,
      void Function(String?) onChanged, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select a $label' : null,
      ),
    );
  }