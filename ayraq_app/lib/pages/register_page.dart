import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'profile_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
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
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initialDate = selectedDate ?? DateTime(2000);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _sendOtp() {
    if (selectedUserType == null || selectedGender == null || dobController.text.isEmpty) {
      _showSnackBar('Please complete all required fields');
      return;
    }

    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            user: {
              'name': nameController.text,
              'userId': phoneController.text,
              'userType': selectedUserType!,
              'gender': selectedGender!,
              'dob': dobController.text,
              'email': emailController.text,
              'phone': phoneController.text,
              'avatar': selectedGender == 'Male'
                  ? 'assets/male_avatar.png'
                  : 'assets/female_avatar.png',
            },
          ),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.grey[800]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(bottom: 40),
            children: [
              Text('Create an Account', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFA602CF))),
              SizedBox(height: 24),

              CustomTextField(
                label: 'Full Name',
                controller: nameController,
                validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'User Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                value: selectedUserType,
                items: userTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (val) => setState(() => selectedUserType = val),
                validator: (value) => value == null ? 'Select user type' : null,
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                value: selectedGender,
                items: genders.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Date of Birth',
                controller: dobController,
                readOnly: true,
                onTap: _pickDate,
                validator: (value) => value == null || value.isEmpty ? 'Select date of birth' : null,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
                  return !regex.hasMatch(value) ? 'Enter valid email' : null;
                },
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter phone number';
                  return !RegExp(r'^\d{10}\$').hasMatch(value) ? 'Phone must be 10 digits' : null;
                },
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Password',
                controller: passwordController,
                isPassword: true,
                validator: (value) => value == null || value.length < 6 ? 'Password too short' : null,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
                validator: (value) => value != passwordController.text ? 'Passwords do not match' : null,
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _sendOtp,
                child: Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA602CF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
