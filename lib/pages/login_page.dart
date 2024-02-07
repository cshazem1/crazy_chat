// ignore_for_file: use_build_context_synchronously


import 'package:crazy_chat/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../firebase/register_user.dart';
import 'home_page.dart';
import '../components/custom_button.dart';
import '../components/custom_form_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  static String id = "LoginIn";

  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  State<LoginPage> createState() => _LoginPageState();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("images/chat_app.png"),
                      const Text(
                        "Crazy Chat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontFamily: 'Honk'),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFromTextField(
                hintText: "Enter Your Email",
                labelText: "Email",
                onChange: (data) {
                  email = data;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFromTextField(
                onChange: (data) {
                  password = data;
                },
                hintText: "Enter Your Password",
                labelText: "Password",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "LogIn",
                onClick: () async {
                  if (_formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await RegisterUser.registerUser(
                          email: email!, password: password!);

                      showSnackBar(context, "success");
                      Navigator.pushNamed(context, HomePage.id,
                          arguments: email!.toLowerCase());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, "No user found fora that email.");
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, "Wrong password provided for that user.");
                      } else if (e.code == 'network-request-failed') {
                        showSnackBar(context, "Check the internet");
                      } else {
                        showSnackBar(context, "password or email not right.");
                      }
                    } catch (e) {
                      String w = e.toString();
                      showSnackBar(context, w);
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    child: const Text(
                      "  Sign Up",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
