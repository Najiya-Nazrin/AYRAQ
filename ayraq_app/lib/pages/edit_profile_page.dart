import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String userId;

  const EditProfilePage({super.key, required this.name, required this.userId});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController userIdController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    userIdController = TextEditingController(text: widget.userId);
  }

  void _saveChanges() {
    // Save logic (update backend or local state)
    Navigator.pop(context); // go back to profile page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text("Save", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(labelText: "User ID"),
            ),
          ],
        ),
      ),
    );
  }
}
