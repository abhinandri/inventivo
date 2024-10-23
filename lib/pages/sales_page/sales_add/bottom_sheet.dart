import 'package:flutter/material.dart';

void showProductSelectionBottomSheet(BuildContext context) {
  // Implement your bottom sheet logic here
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200,
        child: Center(
          child: Text("Product Selection Bottom Sheet"),
        ),
      );
    },
  );
}
