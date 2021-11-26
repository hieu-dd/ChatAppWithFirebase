import 'package:chat_app/widgets/chat/burble_message.dart';
import 'package:chat_app/widgets/chat/send_message_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection('chat')
            .orderBy(
              'createAt',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final docs = snapshot.data?.docs ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (ctx, index) {
                      final doc = docs[index];
                      return BurbleMessage(
                          message: doc['text'],
                          imageUrl: doc['image'],
                          isMe: doc['userId'] == user?.uid);
                    },
                    itemCount: docs.length,
                  ),
                ),
                SendMessageView(),
              ],
            );
          }
        });
  }
}
