import 'package:flutter/material.dart';

class dialogGallery extends StatelessWidget {

  int picture_medium;

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
  int picture_medium;

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
