import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogGallery extends StatelessWidget {

  int pictureMedium;

  DialogGallery(BuildContext context, {Key? key, required this.pictureMedium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, pictureMedium);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Gallery'), Icon(Icons.photo_library_outlined)],
        ));
  }
}

// ignore: must_be_immutable
class DialogCamera extends StatelessWidget {
  int pictureMedium;

  DialogCamera(BuildContext context, {Key? key, required this.pictureMedium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, pictureMedium);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Camera'), Icon(Icons.camera_alt)],
        ));
  }
}
