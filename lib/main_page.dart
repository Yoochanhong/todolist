import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/list_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference product = FirebaseFirestore.instance.collection('items');
  final TextEditingController controller = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    controller.text = documentSnapshot['title'];
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'title'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        final String name = controller.text;
                        product
                            .doc(documentSnapshot.id)
                            .update({"title": name});
                        controller.text = "";
                        Navigator.of(context).pop();
                      },
                      child: Text('업데이트')),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: product.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(documentSnapshot['title']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            _update(documentSnapshot);
                          }, icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.restore_from_trash))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
