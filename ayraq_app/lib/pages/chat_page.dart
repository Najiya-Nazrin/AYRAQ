import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  ChatPage({required this.userName, required this.userAvatar});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'text': text,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
    });
    _controller.clear();
    // Simulate received message
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'text': 'Received: $text',
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.userAvatar)),
            SizedBox(width: 10),
            Text(widget.userName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(msg['text']),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(_controller.text),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
