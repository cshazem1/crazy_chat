
import 'package:crazy_chat/pages/chat_page.dart';
import 'package:crazy_chat/pages/home_page.dart';
import 'package:crazy_chat/pages/login_page.dart';
import 'package:crazy_chat/pages/signup_page.dart';
import 'package:crazy_chat/pages/update_profile.dart';
import 'package:crazy_chat/pages/users_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Ideal time to initialize
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        // Add the line below to get horizontal sliding transitions for routes.
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        }),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        ChatPage.id: (context) => ChatPage(),
        UsersPage.id: (context) => UsersPage(),
        HomePage.id: (context) => HomePage(),
        UpdateProfile.id: (context) => const UpdateProfile(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
