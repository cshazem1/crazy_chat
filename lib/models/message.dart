import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class Message {
  final String message;
  final String id;
  final String idx;
  final String name;
  final Timestamp date;
  final String urImage;
  Message(this.message, this.id, this.idx, this.name, this.date, this.urImage);
  factory Message.fromJason(jason) {
    return Message(jason[kMessage], jason['id'], jason.id, jason['Name'],
        jason['createAt'], jason['UrlImage']);
  }
  factory Message.fromUsers(jason) {
    return Message(jason[kUserName], jason['id'], jason.id, jason['Name'],
        jason['createAt'], jason['UrlImage']);
  }
}
