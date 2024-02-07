import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class CustomCircleImage extends StatelessWidget {
  String urlImage;
  double diameter;
  CustomCircleImage(
      {super.key, required this.urlImage, required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: kPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(100))),
    );
  }
}
