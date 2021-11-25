import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-screen";
  static const MESSAGES_PATH = 'chats/YyROgr02hoII6JwHBNu0/messages';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(MESSAGES_PATH)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Text(documents[index]['text']);
                    },
                    itemCount: documents.length,
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                FirebaseFirestore.instance.collection(MESSAGES_PATH).add({
                  'text':"Add by click"
                });
              },
            ),
          );
        });
  }
}
