import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  VoidCallback onClick;
  CustomButton({super.key, required this.text, required this.onClick});
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.elliptical(40, 25),
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
