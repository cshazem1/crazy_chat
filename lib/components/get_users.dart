import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';
import 'custom_circle_image.dart';
import 'list_view_users.dart';

class GetUsers extends StatelessWidget {
  const GetUsers({
    super.key,
    required this.urlImage,
    required this.appBarName,
    required this.messageList,
    required this.email,
  });

  final String? urlImage;
  final String? appBarName;
  final List<Message> messageList;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircleImage(urlImage: urlImage!, diameter: 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(appBarName ?? "chat",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: UsersListView(messageList: messageList, email: email),
    );
  }
}
