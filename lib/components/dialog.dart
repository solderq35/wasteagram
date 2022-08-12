import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import '../screens/new_post_screen.dart';
import '../components/post_list_view.dart';

class dialogGallery extends StatelessWidget {
  //int dos;
  int picture_medium;

  // final GlobalKey<FormState> formKey;
//  final File? image;

  dialogGallery(BuildContext context, {Key? key, required this.picture_medium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, picture_medium);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Gallery'), Icon(Icons.photo_library_outlined)],
        ));
  }
}

class dialogCamera extends StatelessWidget {
  //int dos;
  int picture_medium;

  // final GlobalKey<FormState> formKey;
//  final File? image;

  dialogCamera(BuildContext context, {Key? key, required this.picture_medium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, picture_medium);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Camera'), Icon(Icons.camera_alt)],
        ));
  }
}
