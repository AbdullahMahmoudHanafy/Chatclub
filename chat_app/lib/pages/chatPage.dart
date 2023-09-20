import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/customChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatPage extends StatelessWidget {
  const chatPage({super.key});

  static String id = "ChatPage";

  @override
  Widget build(BuildContext context) {
    CollectionReference message =
        FirebaseFirestore.instance.collection('messages');
    TextEditingController controller = TextEditingController();

    return FutureBuilder<QuerySnapshot>(
        future: message.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Image.asset(
                      kAppMainImage,
                      height: 50,
                    ),
                    Text("Scholar Chat")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return customChatBubble();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add({'message': data});
                        controller.clear();
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text("Loading");
          }
        });
  }
}
