import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(AYRAQApp());
}

class AYRAQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AYRAQ',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(248, 242, 254, 1.0),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
