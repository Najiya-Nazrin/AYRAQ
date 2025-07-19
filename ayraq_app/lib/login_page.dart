import 'package:flutter/material.dart';
import 'pages/main_navigation.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginMethod { email, phone }

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginMethod _selectedMethod = LoginMethod.email;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggleLoginMethod(LoginMethod method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter phone number';
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) return 'Enter a valid 10-digit phone number';
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color selectedColor = Color(0xFFA602CF);
    final Color unselectedColor = Colors.grey.shade300;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 54),
            Text(
              'Login Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: selectedColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Hello! Welcome Back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 80),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email / Phone Toggle
                        Container(
                          width: size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: unselectedColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _toggleLoginMethod(LoginMethod.email),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedMethod == LoginMethod.email
                                          ? selectedColor
                                          : unselectedColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: _selectedMethod == LoginMethod.email
                                            ? Colors.white
                                            : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _toggleLoginMethod(LoginMethod.phone),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedMethod == LoginMethod.phone
                                          ? selectedColor
                                          : unselectedColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Phone',
                                      style: TextStyle(
                                        color: _selectedMethod == LoginMethod.phone
                                            ? Colors.white
                                            : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Email or Phone Field
                        TextFormField(
                          controller: _selectedMethod == LoginMethod.email
                              ? emailController
                              : phoneController,
                          keyboardType: _selectedMethod == LoginMethod.email
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          validator: _selectedMethod == LoginMethod.email
                              ? _emailValidator
                              : _phoneValidator,
                          decoration: InputDecoration(
                            labelText: _selectedMethod == LoginMethod.email
                                ? 'Email'
                                : 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Password Field
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: _passwordValidator,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),

                        // Forgot Password Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: selectedColor),
                            ),
                          ),
                        ),

                        SizedBox(height: 32),

                        // Login Button
                        SizedBox(
                          width: size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
  if (_formKey.currentState!.validate()) {
    if (_selectedMethod == LoginMethod.email) {
      print('Logging in with Email: ${emailController.text}');
    } else {
      print('Logging in with Phone: ${phoneController.text}');
    }
    print('Password: ${passwordController.text}');

    final Map<String, String> user = {
      'name': '',
      'userId': _selectedMethod == LoginMethod.email
          ? emailController.text
          : phoneController.text,
      'userType': '',
      'gender': '',
      'dob': '',
      'email': emailController.text,
      'phone': phoneController.text,
      'avatar': '',
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainNavigationPage(user: user),
      ),
    );
  }
},

                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    if (_formKey.currentState!.validate()) {
      // Here you would trigger your backend to send the reset email

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mail is sent successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Color(0xFFA602CF);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: selectedColor,
              ),
            ),
            SizedBox(height: 24),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendEmail,
                child: Text('Send'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
