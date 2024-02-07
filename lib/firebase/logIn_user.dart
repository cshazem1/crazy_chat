// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

class LogInUser {
  static Future<void> logInUser(
      {required String email, required String password}) async {

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
