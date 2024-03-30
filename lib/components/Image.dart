// ignore_for_file: file_names

import 'dart:developer';

import '../cuibt/details_sign_cuibt/get_location_image_cubit.dart'
    show GetLocationImageCubit;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageU extends StatefulWidget {
  bool onClick;
  ImageU(this.onClick, {super.key});

  @override
  State<ImageU> createState() => _ImageUState();
}

class _ImageUState extends State<ImageU> {
  File? galleryFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: [
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 15,
                blurRadius: 15,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(200)),
            child: galleryFile == null
                ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("images/not_found_user.jpg"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(200)),
                      width: 200,
                      height: 200,
                    ),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(galleryFile!), fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(200)),
                      width: 200,
                      height: 200,
                    ),
                  ),
          ),
          Positioned(
              right: 60,
              bottom: 7,
              child: SizedBox(
                width: 90,
                height: 55,
                child: widget.onClick
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (!states.contains(MaterialState.pressed)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.5);
                              }
                              return null; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          _showPicker(context: context);
                        },
                        child: const Center(
                            child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25,
                        )))
                    : null,
              ))
        ])
      ],
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xFilePicked = pickedFile;

    setState(
      () {
        log(xFilePicked.toString());
        if(xFilePicked!=null) {
          BlocProvider.of<GetLocationImageCubit>(context)
            .getImageUpload(xFilePicked);
          galleryFile = File(pickedFile!.path);

        }

      },
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
