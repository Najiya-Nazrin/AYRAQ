import 'package:flutter/material.dart';

class SelectionToolPage extends StatelessWidget {
  const SelectionToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> roles = ['Advocate', 'Police', 'Doctor', 'Engineer'];

    return Scaffold(
      appBar: AppBar(title: Text('Selection Tool')),
      body: ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(roles[index]),
            onTap: () {
              // Handle navigation to role list
            },
          );
        },
      ),
    );
  }
}
