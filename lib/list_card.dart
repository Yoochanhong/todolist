import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  ListCard({required this.title});

  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
    );
  }
}
