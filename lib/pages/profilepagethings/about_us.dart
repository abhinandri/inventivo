import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Inventivo!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Inventivo is a comprehensive inventory management app designed to help users efficiently track and manage products. Whether it’s adding products, viewing them by category or brand, managing stock levels, or tracking revenue, Inventivo provides an all-in-one solution for effective inventory management.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '• Add and categorize products\n'
              '• Filter products by category or brand\n'
              '• Manage stock levels: Check low, out of stock, and well-stocked items\n'
              '• Track sales and filter by date\n'
              '• View total revenue and top-selling products in the dashboard\n'
              '• Easy stock availability checks',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'About Us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Inventivo was built using Flutter and Hive, designed to cater to businesses of all sizes, offering an intuitive and seamless user experience. Our mission is to simplify inventory management, making it more efficient and accessible.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
