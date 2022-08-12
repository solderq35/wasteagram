import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class totalAppBar extends StatelessWidget {
  const totalAppBar({Key? key}) : super(key: key);

  // ------------------------------------------------------
  // -------------------- BUILD METHOD --------------------
  // ------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            var total = 0;
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              total += snapshot.data!.docs[i]['quantity'] as int;
            }
            return Text('Wasteagram - $total');
          } else {
            return const Text('Wasteagram');
          }
        });
  }
}
