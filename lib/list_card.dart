import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  ListCard({required this.title, required this.collection, this.doc});

  var title;
  var collection;
  var firescore = FirebaseFirestore.instance;
  var doc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Text(
                      '삭제하시겠습니까?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(onPressed: () {}, child: Text('예')),
                    ElevatedButton(onPressed: () {}, child: Text('아니오')),
                  ],
                );
              });
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 10),
              child: Text(
                '$title',
                style: TextStyle(
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
