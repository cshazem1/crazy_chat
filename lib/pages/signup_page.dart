
import 'package:crazy_chat/cuibt/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/Image.dart';
import '../components/custom_button.dart';
import '../components/custom_form_text_field.dart';
import '../constants.dart';
import '../cuibt/details_sign_cuibt/get_location_image_cubit.dart';
import '../cuibt/details_sign_cuibt/get_location_image_states.dart';
import '../firebase/add_users_firestore.dart';
import '../helper/show_snack_bar.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static String id = "SignUpPage";

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? urlImage;
  String? email;
  String? password;
  String? name;
  String? confirmPassword;
  bool onClick = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => GetLocationImageCubit(),),
        BlocProvider(create: (context) => SignUpCubit(),)
    
      ],
      child: Form(
        key: _formKey,
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              onClick = false;
              isLoading = false;

              showSnackBar(context, "Saved");
              BlocProvider.of<GetLocationImageCubit>(context)
                  .UploadImageToFirebase(
                      BlocProvider.of<GetLocationImageCubit>(context).xFile!);
            } else if (state is SignUpFailure) {
              showSnackBar(context, state.massage);
              isLoading = false;

            } else {
              isLoading = true;
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(children: [
                    const SizedBox(
                      height: 50,
                    ),
                    ImageU(onClick),
                    const Row(
                      children: [
                        Text(
                          "SignIn",
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
                      onChange: (value) {
                        name = value;
                      },
                      hintText: "Enter Your Name",
                      labelText: "Name",
                      onClick: onClick,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFromTextField(
                      onChange: (value) {
                        email = value;
                      },
                      hintText: "Enter Your Email",
                      labelText: "Email",
                      onClick: onClick,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFromTextField(
                      onChange: (value) {
                        password = value;
                      },
                      hintText: "Enter Your Password",
                      labelText: "Password",
                      onClick: onClick,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFromTextField(
                      onChange: (value) {
                        confirmPassword = value;
                      },
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      onClick: onClick,
                    ),
                    BlocBuilder<GetLocationImageCubit, LocationImageStated>(
                      builder: (context, state) {
                        if (state is InitialLocationImageState) {
                          return CustomButton(
                              text: "SignUp",
                              onClick: () {
                                showSnackBar(
                                    context, "Please Enter Your Photo");
                              });
                        } else if (state is ImageUploadStates)
                         {
                           return CustomButton(
                              text: "SignUp",
                              onClick: () async {
                                if (onClick) {
                                  if (_formKey.currentState!.validate()) {
                                    if (confirmPassword == password) {
                                      BlocProvider.of<SignUpCubit>(context)
                                          .logInUser(
                                        email: email!,
                                        password: password!,
                                      );
                                    } else {
                                      showSnackBar(context,
                                          "password and confirm password not matched.");
                                    }
                                  }
                                } else {
                                  showSnackBar(context, "Loading");
                                }

                                isLoading = false;
                                setState(() {});
                              });}
                        else
                         { return (CustomButton(
                            onClick: () async {
                              urlImage = BlocProvider.of<GetLocationImageCubit>(
                                      context)
                                  .locationImage;

                              await addUsers(
                                  email: email!,
                                  name: name!,
                                  urlImage: urlImage!);
                              Navigator.pop(context);

                              Navigator.pushNamed(context, HomePage.id,
                                  arguments: email);
                            },
                            text: "Log In >",
                          ));}
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    onClick
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("already have an account",
                                  style: (TextStyle())),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "  LogIn",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(height: 20),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
