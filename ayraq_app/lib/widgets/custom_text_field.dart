import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
