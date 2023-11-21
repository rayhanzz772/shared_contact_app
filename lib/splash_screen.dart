// splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Call the method to navigate to the home screen
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    Navigator.pushReplacementNamed(
        context, '/'); // Use pushReplacementNamed to replace the splash screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/contact.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
