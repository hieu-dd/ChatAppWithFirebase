import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageView extends StatefulWidget {
  const SendMessageView({Key? key}) : super(key: key);

  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  var _message = '';
  File? _selectedImage;
  var _isSending = false;

  final _textController = TextEditingController();

  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() {
      _isSending = true;
    });
    final fireStore = FirebaseFirestore.instance;
    var imageUrl = null;
    if (_selectedImage != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child(user.uid)
          .child(Timestamp.now().toString());
      await ref.putFile(_selectedImage!);
      imageUrl = await ref.getDownloadURL();
    }

    fireStore.collection('chat').add({
      'text': _message,
      'createAt': Timestamp.now(),
      'userId': user.uid,
      'image': imageUrl,
    });

    _textController.text = "";
    _selectedImage = null;
    setState(() {
      _isSending = false;
      _message = "";
    });
  }

  void _onChangeText(String value) {
    setState(() {
      _message = value;
    });
  }

  void _selectImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = result != null ? File(result.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: _selectImage, icon: Icon(Icons.image)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: double.infinity,
                child: TextField(
                  controller: _textController,
                  onChanged: _onChangeText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Entered text you want to send",
                  ),
                ),
              ),
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
            ],
          ),
        ),
        _isSending
            ? CircularProgressIndicator()
            : IconButton(
                color: Theme.of(context).primaryColor,
                onPressed: _sendMessage,
                icon: Icon(_message.isEmpty ? Icons.favorite : Icons.send),
              )
      ],
    );
  }
}
