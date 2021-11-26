import 'package:flutter/material.dart';

class BurbleMessage extends StatelessWidget {
  final String message;
  final String? imageUrl;
  final bool isMe;

  const BurbleMessage({
    required this.message,
    required this.imageUrl,
    required this.isMe,
    key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          alignment: isMe
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          width: 250,
          child: imageUrl != null && !imageUrl!.isEmpty
              ? Image.network(
                  imageUrl!,
                  width: 200,
                  fit: BoxFit.fitHeight,
                )
              : message.isEmpty
                  ? Icon(
                      Icons.favorite,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    )
                  : Container(
                      constraints: BoxConstraints(
                        minHeight: 40,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? theme.primaryColor : Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(isMe ? 15 : 0),
                          bottomRight: Radius.circular(isMe ? 0 : 15),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
        )
      ],
    );
  }
}
