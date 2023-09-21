import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messageModel.dart';

class customChatBubble extends StatelessWidget {
  const customChatBubble({required this.messageComing});

  final messageModel messageComing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              messageComing.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}

class customChatBubbleForFriend extends StatelessWidget {
  const customChatBubbleForFriend({required this.messageComing});

  final messageModel messageComing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              messageComing.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}
