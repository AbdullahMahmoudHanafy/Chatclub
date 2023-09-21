import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messageModel.dart';
import 'package:scholar_chat/widgets/customChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatPage extends StatelessWidget {
  chatPage({super.key});

  static String id = "ChatPage";

  final ScrollController _controller = ScrollController();
  void _scrollDown() {
    _controller.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    CollectionReference message =
        FirebaseFirestore.instance.collection(kMessagesCollections);
    TextEditingController controller = TextEditingController();

    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<messageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(messageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Image.asset(
                      kAppMainImage,
                      height: 50,
                    ),
                    Text("fu*k whatsapp")
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
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (messagesList[index].id == email) {
                            return customChatBubble(
                              messageComing: messagesList[index],
                            );
                          } else {
                            return customChatBubbleForFriend(
                              messageComing: messagesList[index],
                            );
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add({
                          KMessage: data,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _scrollDown();
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
