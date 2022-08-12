import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'new_post_screen.dart';
import '../components/post_list_view.dart';
import '../components/dialog.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);

  // for image selection and storage
  File? image;
  final picker = ImagePicker();

  // Upon pressing the add post button, chooseImageSource() is called
  // which shows a dialog to choose between camera and gallery.
  // Based on selection, pick image from source and save.
  //
  // modified from Flutter documentation -
  // https://api.flutter.dev/flutter/material/SimpleDialog-class.html
  Future<void> chooseImageSource(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select image source'),
            children: [
              dialogCamera(context, picture_medium: 1),
              dialogGallery(
                context,
                picture_medium: 2,
              ),
            ],
          );
        })) {
      case 1:
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        // if user clicks outside of dialog or cancels taking photo, image will
        // be null and will pass null to new post screen
        if (pickedFile != null) {
          image = File(pickedFile.path);
        }
        break;
      case 2:
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          // if user clicks outside of dialog or cancels
          image = File(pickedFile.path);
        }
        break;
    }
  }

  // ------------------------------------------------------
  // -------------------- BUILD METHOD --------------------
  // ------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: const PostListView(),
      floatingActionButton: Builder(
        builder: (context) {
          return Semantics(
            button: true,
            onTapHint: 'Press to create a new post',
            child: FloatingActionButton(
                onPressed: () async {
                  await chooseImageSource(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewPostScreen(image: image)));
                },
                child: const Icon(Icons.add_outlined)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
