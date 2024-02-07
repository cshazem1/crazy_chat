import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

void addMessage(text, friendMessageComponents) {
  if (text != null) {
    FirebaseFirestore.instance
        .collection(kUserName)
        .doc(friendMessageComponents!.sender)
        .collection('chat')
        .doc(friendMessageComponents!.receiver)
        .collection("message")
        .add({
      kMessage: text,
      'createAt': DateTime.now(),
      'id': friendMessageComponents!.sender,
      "Name": friendMessageComponents!.name // John Doe
      ,
      "UrlImage": friendMessageComponents!.urlImage
      // 42
    });
  }
}
