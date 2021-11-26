import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, userSnapshot) {
                    return MaterialApp(
                      title: 'Chat app',
                      theme: ThemeData(
                        primarySwatch: Colors.pink,
                        iconTheme: IconThemeData(color: Colors.pink),
                      ),
                      home: userSnapshot.hasData
                          ? const ChatScreen()
                          : AuthScreen(),
                    );
                  },
                )
              : Container();
        });
  }
}
