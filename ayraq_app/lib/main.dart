import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:ayraq_app/pages/overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AYRAQApp());
}
// Overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  showOverlay();
}

class AYRAQApp extends StatelessWidget {
  const AYRAQApp({super.key});
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
