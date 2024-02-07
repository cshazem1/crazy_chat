
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/chat_bubble.dart';
import '../components/custom_circle_image.dart';
import '../constants.dart';
import '../firebase/add_friend_message.dart';
import '../firebase/add_my_message.dart';
import '../models/message.dart';
import '../models/message_components.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ScrollController controller = ScrollController();

  static String id = "ChatPage";
  String? text;
  String? getText;
  MessageComponents? friendMessageComponents;
  CollectionReference? message;

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    friendMessageComponents =
        ModalRoute.of(context)!.settings.arguments as MessageComponents?;
    createAGroupForChat();
    TextEditingController textController = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
        stream: message!.orderBy('createAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];

            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJason(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleImage(
                        urlImage: friendMessageComponents!.urlImage!,
                        diameter: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(friendMessageComponents?.name ?? "chat",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          if (messageList[index].id ==
                              friendMessageComponents!.sender) {
                            return ChatBubble(
                              message: messageList[index],
                              friendId: friendMessageComponents!.receiver!,
                            );
                          } else {
                            return ChatBubbleFromFriend(
                                message: messageList[index],
                                urlImageFriend:
                                    friendMessageComponents!.urlImage!);
                          }
                        }),
                  ),
                  messageList.length > 10
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton.small(
                              heroTag: "btn3",
                              elevation: 10,
                              onPressed: scrollUp,
                              child: const Icon(Icons.arrow_upward),
                            ),
                            FloatingActionButton.small(
                              heroTag: "btn4",
                              elevation: 10,
                              onPressed: scrollDown,
                              child: const Icon(Icons.arrow_downward_sharp),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          controller: textController,
                          onChanged: (value) {
                            text = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Send Message",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              color: kPrimaryColor,
                              onPressed: () {
                                addMessage(text, friendMessageComponents);
                                addMessageFreinds(
                                    text, friendMessageComponents);
                                text = null;
                                textController.clear();
                                scrollDown();
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: kPrimaryColor)),
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else {
            {
              return ModalProgressHUD(
                  inAsyncCall: true,
                  child: Scaffold(
                    appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: kPrimaryColor),
                  ));
            }
          }
        });
  }

// This is what you're looking for!

  void createAGroupForChat() {
    message = FirebaseFirestore.instance
        .collection(kUserName)
        .doc(friendMessageComponents!.sender)
        .collection('chat')
        .doc(friendMessageComponents!.receiver)
        .collection("message");
  }

  void scrollUp() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 5),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void scrollDown() {
    controller.animateTo(
      controller.position.minScrollExtent,
      duration: const Duration(seconds: 5),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }
}
