import 'dart:io';
import 'package:flutter/material.dart';

class displayImage extends StatelessWidget {
  // final GlobalKey<FormState> formKey;
  final File? image;

  const displayImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (image == null) {
      // display progress indicator
      child = const Center(child: CircularProgressIndicator());
    } else {
      // display image
      child = Semantics(
        image: true,
        label: 'Selected image',
        child: Image.file(image as File),
      );
    }

    return SizedBox(
      height: 350,
      child: child,
    );
  }
}
