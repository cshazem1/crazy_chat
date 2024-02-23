import 'package:crazy_chat/pages/update_profile.dart';
import 'package:crazy_chat/pages/upload_image.dart';
import 'package:crazy_chat/pages/users_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var email;
  static String id = "buttonBar";

  HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.email = ModalRoute.of(context)!.settings.arguments;
    UsersPage.email = widget.email;
    return Scaffold(
      body: Center(
          child: _selectedIndex == 0
              ? UsersPage()
              : _selectedIndex == 1
                  ? UpdateProfile()
                  : const UpdateImage()),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.deepOrange[100]!,
              hoverColor: Colors.blue[100]!,
              gap: 8,
              activeColor: kPrimaryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey.withOpacity(.3),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.supervised_user_circle_rounded,
                  text: 'Users',
                ),
                GButton(
                  icon: Icons.chat,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
