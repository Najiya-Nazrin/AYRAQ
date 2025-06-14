import 'package:flutter/material.dart';

class DobPicker extends StatelessWidget {
  final TextEditingController controller;

  const DobPicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date of Birth",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          controller.text = "${date.day}/${date.month}/${date.year}";
        }
      },
    );
  }
}
