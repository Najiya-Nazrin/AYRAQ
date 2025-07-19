import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  final Function(Map<String, String>) onAccept;

  const RequestsPage({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    final requests = List.generate(5, (index) => {
      'name': 'User $index',
      'avatar': 'https://i.pravatar.cc/150?img=${index + 10}',
      'message': 'Wants to connect',
      'time': '10:${index} AM',
    });

    return Scaffold(
      appBar: AppBar(title: Text('Requests')),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final user = requests[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user['avatar']!)),
            title: Text(user['name']!),
            subtitle: Text(user['message']!),
            trailing: ElevatedButton(
              child: Text("Accept"),
              onPressed: () {
                onAccept(user); // 🔄 add to accepted list
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${user['name']} accepted!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
