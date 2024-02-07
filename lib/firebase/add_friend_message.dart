import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

void addMessageFreinds(text, friendMessageComponents) {
  if (text != null) {
    FirebaseFirestore.instance
        .collection(kUserName)
        .doc(friendMessageComponents!.receiver)
        .collection('chat')
        .doc(friendMessageComponents!.sender)
        .collection("message")
        .add({
      kMessage: text, 'createAt': DateTime.now(),
      'id': friendMessageComponents!.sender,
      "Name": friendMessageComponents!.name,
      "UrlImage": friendMessageComponents!.urlImage

      /// John Doe

      // 42
    });
  }
}
