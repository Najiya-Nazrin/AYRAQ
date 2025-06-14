import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  final String phone;
  OTPVerificationPage({required this.phone});

  final TextEditingController otpController = TextEditingController();

  void verifyOtp(BuildContext context) {
    if (otpController.text == '1234') {
      // Example only; match OTP with backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP Verified!')),
      );
      // Navigate to dashboard or home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Enter the OTP sent to $phone'),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyOtp(context),
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
