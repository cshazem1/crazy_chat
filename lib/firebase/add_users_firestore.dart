import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

Future<void> addUsers(
    {required String email, required String name, required String urlImage}) async {
  CollectionReference message =
      FirebaseFirestore.instance.collection(kUserName);
 await message.add({
    kUserName: email, 'createAt': DateTime.now(), 'id': email,
    "Name": name, "UrlImage": urlImage
    // John Doe

    // 42
  });
}
