import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text("My words");
        },
        itemCount: 10,
      ),
    );
  }
}
