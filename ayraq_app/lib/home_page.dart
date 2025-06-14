import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'components/heading_description.dart';
import 'login_page.dart';
import 'pages/register_page.dart'; 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Light pink theme
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Center(
                child: Image.asset(
                  'assets/home.jpg',
                  width: size.width * 0.75,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: HeadingAndDescription(
                heading: "Smart Protection for a Safer Tomorrow",
                description:
                    "An app that uses AI to detect online threats against women and alerts the right people when needed.",
              ),
            ),

            const Spacer(),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 185, 255, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  CustomButton(
                    text: "Login",
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    text: "Create an Account",
                    color: const Color.fromARGB(255, 166, 2, 207),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage()), // ✅ Link to RegisterPage
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
