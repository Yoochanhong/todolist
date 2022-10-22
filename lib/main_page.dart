import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var firestore = FirebaseFirestore.instance;
  var collection = 'todo';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('투두리스트'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      firestore.collection(collection).doc(controller.text).set({
                        'title': controller.text
                      });
                    },
                    child: const Text(
                      '입력',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
