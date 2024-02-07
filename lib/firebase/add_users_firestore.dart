import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

void addUsers(
    {required String email, required String name, required String urlImage}) {
  CollectionReference message =
      FirebaseFirestore.instance.collection(kUserName);
  message.add({
    kUserName: email, 'createAt': DateTime.now(), 'id': email,
    "Name": name, "UrlImage": urlImage
    // John Doe

    // 42
  });
}
