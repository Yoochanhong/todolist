import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/list_card.dart';

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
    final DocumentSnapshot documentSnapshot;
    return Scaffold(
      appBar: AppBar(
        title: Text('투두리스트'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection(collection).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: 300,
                      height: 500,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          return ListCard(title: snapshot.data!.docs[index]['title'].toString());
                        },
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '텍스트를 입력해주세요',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        firestore
                            .collection(collection)
                            .doc(controller.text)
                            .set({'title': controller.text});
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
