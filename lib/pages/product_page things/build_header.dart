import 'package:flutter/material.dart';

class build_sectionHeader extends StatelessWidget {
  const build_sectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllPressed,
  });

  final String title;
  final VoidCallback onSeeAllPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }
}
