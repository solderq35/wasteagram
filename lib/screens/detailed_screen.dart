import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({Key? key, required this.post}) : super(key: key);

  final QueryDocumentSnapshot<Object?> post; // post data from database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // date
            Text(
                DateFormat('EEE, MMMM dd, yyyy')
                    .format(DateTime.fromMillisecondsSinceEpoch(post['date'])),
                style: Theme.of(context).textTheme.headline5),

            // image
            Semantics(
                image: true,
                label: 'Food waste item image',
                child: Image.network(post['imageURL'])),

            // item quantity
            Text('${post['quantity'].toString()} items',
                style: Theme.of(context).textTheme.headline5),

            // GPS location
            Text(
                'Location: (${post['latitude'].toString()}, ${post['longitude'].toString()})',
                style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
    );
  }
}
