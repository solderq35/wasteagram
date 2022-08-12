import 'dart:io';
import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';

// ignore: must_be_immutable
class QuantityInput extends StatelessWidget {
  final File? image;
  FoodWastePost post = FoodWastePost();

  QuantityInput({Key? key, required this.image, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
            hintText: 'Number of Wasted Items', border: UnderlineInputBorder()),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          if (value != null) {
            post.quantity = int.parse(value);
          }
        },
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Please enter a number of items';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
