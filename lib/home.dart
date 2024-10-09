import 'package:flutter/material.dart';
import 'package:project/login.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                 Color(0xFFA1F6FB)
                ],
              ),
            ),
          ),
          const Center(   
            child: Text(
              'Inventivo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF17A2B8)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 110, vertical: 20), // Padding
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
