import 'package:chat_app/widgets/chat/messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-screen";
  static const MESSAGES_PATH = 'chats/YyROgr02hoII6JwHBNu0/messages';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Messages(),
    );
  }
}
