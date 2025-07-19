import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class LoggedInHomePage extends StatelessWidget {
  final List<Map<String, String>> acceptedUsers;

  const LoggedInHomePage({super.key, required this.acceptedUsers});

  Future<void> showOverlay() async {
    bool granted = await FlutterOverlayWindow.isPermissionGranted();
    if (!granted) {
      await FlutterOverlayWindow.requestPermission();
    }

    await FlutterOverlayWindow.showOverlay(
      height: 500,
      width: 300,
      alignment: OverlayAlignment.centerRight,
      flag: OverlayFlag.defaultFlag,
      enableDrag: true,
    );
  }

  Future<void> closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: Column(
        children: [
          // Expanded makes the list take all available space except what's needed for buttons
          Expanded(
            child: acceptedUsers.isEmpty
                ? const Center(child: Text("No accepted chats yet."))
                : ListView.builder(
                    itemCount: acceptedUsers.length,
                    itemBuilder: (context, index) {
                      final user = acceptedUsers[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user['avatar']!),
                            ),
                            title: Text(user['name']!),
                            subtitle: const Text("Tap to chat"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    userName: user['name']!,
                                    userAvatar: user['avatar']!,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          ),
          // Overlay control buttons positioned above the natural bottom area
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: showOverlay,
                  child: const Text("Show PiP Button"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: closeOverlay,
                  child: const Text("Close PiP"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}