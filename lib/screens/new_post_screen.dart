import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../models/food_waste_post.dart';
import '../components/display_image.dart';
import '../components/entry_input.dart';

class NewPostScreen extends StatefulWidget {
  File? image;

  NewPostScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState(image: image);
}

class _NewPostScreenState extends State<NewPostScreen> {
  _NewPostScreenState({required this.image});

  // for GPS
  LocationData? locationData;
  final locationService = Location();

  // for image selection and storage
  final File? image;
  final picker = ImagePicker();

  // for form reference
  final formKey = GlobalKey<FormState>();

  // data transfer object for submitting form
  final post = FoodWastePost();

  // Upload image to Firebase Cloud Storage and get the URL of image for
  // storage in the database

  // ------------------------------------------------------
  // -------------------- BUILD METHOD --------------------
  // ------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                displayImage(
                  image: image,
                ),
                /*
                itemNameInput(
                  image: image,
                  post: post,
                ),
                */
                quantityInput(
                  image: image,
                  post: post,
                ),
                uploadButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // validate input, upload image to cloud,
  // gather data for upload to database in data transfer object 'post',
  // write to database, then return to previous screen
  Widget uploadButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Semantics(
        button: true,
        onTapHint: 'Press to upload the post',
        child: ElevatedButton(
            onPressed: () async {
              var isValid = formKey.currentState?.validate();
              if (isValid != null && isValid) {
                formKey.currentState?.save();

                // upload image to Cloud Firestore
                await uploadImage();

                // add date to post
                // post.date = DateFormat('EEE, MMMM dd, yyyy').format(DateTime.now());
                post.date = DateTime.now().millisecondsSinceEpoch;

                // add location to post
                await retrieveLocation();

                // write to database
                await FirebaseFirestore.instance
                    .collection('posts')
                    .add(post.toMap());

                // return to list screen
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(100)),
            child: const Icon(
              Icons.cloud_upload_rounded,
              size: 75.0,
            )),
      ),
    );
  }

  Future uploadImage() async {
    var fileName = '${DateTime.now()}.jpg'; // create unique filename
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    await storageReference.putFile(image!);
    // get URL of uploaded image to save to database
    post.imageURL = await storageReference.getDownloadURL();
  }

  // Obtain GPS location of device and save to DTO to be uploaded to database
  // Modified from location package documentation - https://pub.dev/packages/location
  Future retrieveLocation() async {
    try {
      // check if service is enabled and request service if not enabled
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          post.latitude = 0;
          post.longitude = 0;
          return;
        }
      }

      // check for permission and request permission if necessary
      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
          post.latitude = 0;
          post.longitude = 0;
          return;
        }
      }

      // get location data and save to data transfer object
      locationData = await locationService.getLocation();
      post.latitude = locationData?.latitude;
      post.longitude = locationData?.longitude;

      // default to (0, 0) upon error
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
      post.latitude = 0;
      post.longitude = 0;
    }

    setState(() {});
  }
}
