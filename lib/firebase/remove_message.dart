import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

Future<void> removeCollection(myId, friendId, id) async {
  try {
    // Reference to the collection
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(kUserName)
        .doc(myId)
        .collection("chat")
        .doc(friendId)
        .collection("message");

    // Get all documents in the collection
    QuerySnapshot querySnapshot = await collectionReference.get();

    // Delete each document in the collection
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.id.toString() == id) {
        documentSnapshot.reference.delete();
      }
    }

    // Delete the collection itself
    await collectionReference.doc().delete();
  } catch (e) {
    return log("error");
  }
}
