import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryLists extends StatefulWidget {
  const EntryLists({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EntryListsState createState() => _EntryListsState();
}

class _EntryListsState extends State<EntryLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wastegram')),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('bandnames').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                // ignore: unnecessary_null_comparison
                snapshot.data!.docs != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return ListTile(
                        title: Text(post['name']),
                        subtitle: Text(post['votes'].toString()));
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: const NewEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
 * As an example I have added functionality to add an entry to the collection
 * if the button is pressed
 */
class NewEntryButton extends StatelessWidget {
  const NewEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('bandnames')
              .add({'name': 'Rusty Laptop', 'votes': 22});
        });
  }
}
