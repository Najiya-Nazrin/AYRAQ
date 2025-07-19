import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, String> user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, String> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Profile"),
            onTap: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(
                    name: user['name']!,
                    userId: user['userId']!,
                  ),
                ),
              );

              // 🔁 Update user details after editing
              if (result != null && result is Map<String, String>) {
                setState(() {
                  user['name'] = result['name']!;
                  user['userId'] = result['userId']!;
                });
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Remove Account"),
            onTap: () {
              Navigator.pop(context);
              // TODO: Handle account removal
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMenu(context),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(user['avatar']!),
            ),
            SizedBox(height: 12),
            Text(user['name']!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildDetailRow("User ID", user['userId']!),
            _buildDetailRow("User Type", user['userType']!),
            _buildDetailRow("Gender", user['gender']!),
            _buildDetailRow("DOB", user['dob']!),
            _buildDetailRow("Email", user['email']!),
            _buildDetailRow("Phone", user['phone']!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$title:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
