import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/detailed_screen.dart';

class PostListView extends StatelessWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        DateFormat('EEE, MMMM dd, yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(post['date']),
                        ),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      trailing: Text(
                        post['quantity'].toString(),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailedScreen(post: post)));
                      },
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
