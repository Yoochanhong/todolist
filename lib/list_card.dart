import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  ListCard({Key? key, required this.title}) : super(key: key);

  var title;
  var product = FirebaseFirestore.instance.collection('items');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails dragEndDetails){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const SingleChildScrollView(
                    child: Text(
                      '삭제하시겠습니까?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          //product.doc(doc).delete();
                          Navigator.of(context).pop();
                        },
                        child: const Text('예')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('아니오')),
                  ],
                );
              });
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 10),
              child: Text(
                '$title',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}