import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_entry_post.dart';
import 'new_entry_post.dart';
import '../widgets/detailed_post_body.dart';
import '../widgets/dialog.dart';
import '../widgets/total_app_bar.dart';
import '../widgets/sentry_drawer.dart';

// ignore: must_be_immutable
class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);

  // for image selection and storage
  File? image;
  final picker = ImagePicker();
  num totalCount = 0;

  // Function to choose between camera or gallery for image source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const TotalAppBar()),
      body: const PostListView(),
      drawer: const SentryTestDrawer(),
      floatingActionButton: Builder(
        builder: (context) {
          return Semantics(
            button: true,
            onTapHint: 'Press to create a new post',
            child: FloatingActionButton(
                onPressed: () async {
                  await chooseImageSource(context);
                  // ignore: use_build_context_synchronously
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

  Future<void> chooseImageSource(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select image source'),
            children: [
              CameraDialogChoice(context, pictureMedium: 1),
              GalleryDialogChoice(
                context,
                pictureMedium: 2,
              ),
            ],
          );
        })) {
      case 1:
        final chosenFile = await picker.pickImage(source: ImageSource.camera);

        // if user clicks outside of dialog or cancels taking photo, image will
        // be null and will pass null to new post screen
        if (chosenFile != null) {
          image = File(chosenFile.path);
        }
        break;

      case 2:
        final chosenFile = await picker.pickImage(source: ImageSource.gallery);
        if (chosenFile != null) {
          // if user clicks outside of dialog or cancels
          image = File(chosenFile.path);
        }
        break;
    }
  }
}
