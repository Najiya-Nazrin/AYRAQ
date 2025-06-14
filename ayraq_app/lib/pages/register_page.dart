import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart'; // CustomTextField widget
import 'otp_verification_page.dart'; // OTP Verification Page

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? selectedUserType;
  String? selectedGender;
  DateTime? selectedDate;

  final List<String> userTypes = ['Lawyer', 'Doctor', 'Police', 'Others'];
  final List<String> genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initialDate = selectedDate ?? DateTime(2000);
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _sendOtp() {
    if (selectedUserType == null) {
      _showSnackBar('Please select a User Type');
      return;
    }
    if (selectedGender == null) {
      _showSnackBar('Please select a Gender');
      return;
    }
    if (dobController.text.isEmpty) {
      _showSnackBar('Please select your Date of Birth');
      return;
    }

    if (_formKey.currentState!.validate()) {
      print("User Type: $selectedUserType");
      print("Gender: $selectedGender");
      print("Date of Birth: ${dobController.text}");
      print("Email: ${emailController.text}");
      print("Phone: ${phoneController.text}");
      print("Password: ${passwordController.text}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OTPVerificationPage(phone: phoneController.text),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 90, 88, 88),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(bottom: 40),
            children: [
              // Heading and Subheading
              Text(
                'Create an Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA602CF),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Hello! Let's Create an account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'User Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                value: selectedUserType,
                items: userTypes
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (val) => setState(() => selectedUserType = val),
                validator: (value) => value == null ? 'Please select user type' : null,
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                value: selectedGender,
                items: genders
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                validator: (value) => value == null ? 'Please select gender' : null,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Date of Birth',
                controller: dobController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: _pickDate,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select your date of birth' : null,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your email';
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your phone number';
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Phone number must be 10 digits';
                  return null;
                },
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Password',
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter a password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Confirm your password';
                  if (value != passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              SizedBox(height: 24),

              SizedBox(
                width: size.width * 0.9,
                child: ElevatedButton(
                  onPressed: _sendOtp,
                  child: Text('Send OTP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA602CF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
