
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/message.dart';
import '../models/message_components.dart';
import '../pages/chat_page.dart';
import 'custom_circle_image.dart';
// ignore: must_be_immutable
class UserCardFromFriend extends StatelessWidget {
  Message message;
  static String? idReceive;
  UserCardFromFriend({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String urlImage=message.urImage;

    MessageComponents messageComponents =
        MessageComponents(message.name, message.idx, idReceive,urlImage);

    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ChatPage.id, arguments: messageComponents);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 16, right: 2, bottom: 12),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: SizedBox(
              height: 110,
              width: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,

                  children: [
                    CustomCircleImage(urlImage: urlImage,diameter:100 )
,                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              shadows: CupertinoContextMenu.kEndBoxShadow)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message.message,
                          style: TextStyle(
                              color: Colors.black87.withOpacity(.6),
                              fontWeight: FontWeight.bold,
                              shadows: CupertinoContextMenu.kEndBoxShadow)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "date of registration ${message.date.toDate().day.toString()}/${message.date.toDate().month.toString()}/${message.date.toDate().year.toString()}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(.4),
                              fontWeight: FontWeight.bold,
                              shadows: CupertinoContextMenu.kEndBoxShadow)),
                    ),
                  ],
                )
              ]),
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class UserCard extends StatelessWidget {
  Message message;
  static String? idReceive;
  UserCard ({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String urlImage=message.urImage;


    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 16, right: 2, bottom: 12),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: kPrimaryColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: SizedBox(
          width: double.infinity,
          height: 110,
          child: ListView(
              physics: const BouncingScrollPhysics(),

              scrollDirection: Axis.horizontal,
              children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          shadows: CupertinoContextMenu.kEndBoxShadow)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.message,
                      style: TextStyle(

                          color: Colors.black87.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          shadows: CupertinoContextMenu.kEndBoxShadow)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "date of registration ${message.date.toDate().day.toString()}/${message.date.toDate().month.toString()}/${message.date.toDate().year.toString()}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.4),
                          fontWeight: FontWeight.bold,
                          shadows: CupertinoContextMenu.kEndBoxShadow)),
                ),
              ],
            ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:  NetworkImage(urlImage
                          ),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(100))),
                ),

              ]),
        ),
      ),
    );
  }

}