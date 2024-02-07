// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_circle_image.dart';
import '../components/list_view_users.dart';
import '../components/user_card.dart';
import '../constants.dart';
import '../models/message.dart';

class UsersPage extends StatelessWidget {
  static String id = "UsersPage";
  static String? email;
  String? text;
  String? appBarName;
  String? urlImage;
  UsersPage({super.key});
  CollectionReference users = FirebaseFirestore.instance.collection(kUserName);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.orderBy('createAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromUsers(snapshot.data!.docs[i]));
              if (messageList[i].id == email) {
                UserCardFromFriend.idReceive = messageList[i].idx;
                appBarName = messageList[i].name;
                urlImage = messageList[i].urImage;
              }
            }
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleImage(
                        urlImage: urlImage ??
                            "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-0.jpg",
                        diameter: 60),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(appBarName ?? "chat",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              body: UsersListView(messageList: messageList, email: email),
            );
          } else {
            return ModalProgressHUD(
                inAsyncCall: true,
                child: Scaffold(
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: kPrimaryColor),
                ));
          }
        });
  }
}
