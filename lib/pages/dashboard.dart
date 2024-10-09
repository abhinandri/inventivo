import 'package:flutter/material.dart';

import 'package:project/pages/dashboard2.dart';
import 'package:project/pages/product_page%20things/inventory_page.dart';
import 'package:project/pages/profile.dart';
import 'package:project/pages/sales_page/billing.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    Dashboard2(),
  
   Inventory(),
     SalesPage(),

    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard,),
            label: 'Dashboard',
          ),

         
          
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),

         
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: 'Profile',
          ),
        ],
          selectedItemColor: Color(0xFF17A2B8),
            unselectedItemColor: Color(0xFF90A4AE),      // Color for unselected items

      ),
    );
  }
}
