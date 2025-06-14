import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isPrecached) {
      precacheImage(const AssetImage('assets/home.jpg'), context);
      _isPrecached = true;

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = screenWidth * 0.6; // 30% of screen width

    return Scaffold(
      backgroundColor: const Color(0xFFF8F2FE),
      body: Center(
        child: Image.asset(
          'assets/logo.jpeg',
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
