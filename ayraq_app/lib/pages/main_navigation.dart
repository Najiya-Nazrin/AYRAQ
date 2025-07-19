import 'package:flutter/material.dart';
import 'home_page_loggedin.dart';
import 'selection_tool_page.dart';
import 'requests_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  final Map<String, String> user; // ✅ Accept user data from registration

  const MainNavigationPage({super.key, required this.user});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // ✅ Shared accepted users list
  List<Map<String, String>> acceptedUsers = [];

  // ✅ Callback to add a user to accepted list
  void addAcceptedUser(Map<String, String> user) {
    if (!acceptedUsers.any((u) => u['name'] == user['name'])) {
      setState(() => acceptedUsers.add(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Define tab pages with required data
    final List<Widget> _pages = [
      LoggedInHomePage(acceptedUsers: acceptedUsers),
      const SelectionToolPage(),
      RequestsPage(onAccept: addAcceptedUser),
      ProfilePage(user: widget.user), // ✅ Use passed user data here
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFA602CF),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.select_all), label: 'Selection'),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
