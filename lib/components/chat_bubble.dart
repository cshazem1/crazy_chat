import 'package:flutter/material.dart';
import '../constants.dart';
import '../firebase/remove_message.dart';
import '../models/message.dart';
import 'custom_circle_image.dart';

// ignore: must_be_immutable
class ChatBubbleFromFriend extends StatelessWidget {
  String? friendId;
  Message message;
  String urlImageFriend;
  ChatBubbleFromFriend(
      {super.key, required this.message, required this.urlImageFriend});

  @override
  Widget build(BuildContext context) {
    friendId = message.id;

    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CustomCircleImage(urlImage: urlImageFriend, diameter: 45),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(left: 5, right: 100, bottom: 12),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.8),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Text(
                  message.message,
                  style: const TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
  String friendId;
  String? myId;
  Message message;

  ChatBubble({super.key, required this.message, required this.friendId});

  @override
  Widget build(BuildContext context) {
    myId = message.id;

    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {
          removeCollection(myId, friendId, message.idx);
        },
        child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 16, left: 100, bottom: 12),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
