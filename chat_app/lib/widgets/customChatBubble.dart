import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

class customChatBubble extends StatelessWidget {
  const customChatBubble({
    super.key,
  });

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
              "I am a user",
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
