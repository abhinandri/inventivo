// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/home.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/dashboard.dart';
// Adjust the import path as needed

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
    _navigateToNextScreen();
  }
  

  Future<void> _navigateToNextScreen() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Open Hive box



        
    final userBox = await Hive.openBox<UserModel>('user_db');
    final user = userBox.isNotEmpty ? userBox.getAt(0) as UserModel? : null;


        // Log user details for debugging
      print('User retrieved: ${user?.name ?? 'No user'}');
     

  // Check if user data exists
  if (userBox.isNotEmpty) {
    print('User data exists in Hive.');
  } else {
    print('No user data found in Hive.');
  }



    // Check if user is logged in
    if (user != null && user.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 250,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/app_logo/pixelcut-export.png'), // Your image asset
      fit: BoxFit.cover, // Adjust this based on how you want the image to fit
    ),
  ),
),

         
            // SizedBox(height: 20),
            // Text(
            //   'inventivo',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            // ),
          ],
        ),
      ),
    );
  }
}
