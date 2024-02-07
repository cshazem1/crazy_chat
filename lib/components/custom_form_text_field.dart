import 'dart:core';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFromTextField extends StatefulWidget {
  Function(String) onChange;
  String? hintText;
  String? labelText;
  bool? onClick;

  CustomFromTextField(
      {super.key,
      this.hintText,
      this.labelText,
      required this.onChange,
      this.onClick});

  @override
  State<CustomFromTextField> createState() => _CustomFromTextFieldState();
}

class _CustomFromTextFieldState extends State<CustomFromTextField> {
  bool onView = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.onClick,
      validator: (value) {
        if (value!.isEmpty) {
          return "The field is required";
        }
        return null;
      },
      obscureText: widget.labelText == "Password" ||
              widget.labelText == "Confirm Password"
          ? onView
              ? true
              : false
          : false,
      onChanged: widget.onChange,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              onView = !onView;
              setState(() {});
            },
            child: Icon(widget.labelText == "Password" ||
                    widget.labelText == "Confirm Password"
                ? onView
                    ? Icons.visibility_off
                    : Icons.visibility_sharp
                : null),
          ),
          hintText: widget.hintText,
          hintStyle: (TextStyle(color: Colors.white.withOpacity(.5))),
          labelText: widget.labelText,
          labelStyle: (const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )),
    );
  }
}
