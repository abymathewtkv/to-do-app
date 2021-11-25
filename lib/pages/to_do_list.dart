import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ToDoListPage({Key? key}) : super(key: key);

  void addTask() {
    FirebaseFirestore.instance
        .collection('todos')
        .add({"title": _controller.text});
  }

  onDelete(String id) {
    FirebaseFirestore.instance.collection("todos").doc(id).delete();
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.pinkAccent, width: 2.0)),
                    hintText: 'Type here',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.pink[200],
              ),
              child: TextButton(
                onPressed: () {
                  addTask();
                },
                child: const Text(
                  'Add task',
                  style: TextStyle(
                      color: Colors.black, fontWeight: (FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('todos').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) {
                          onDelete(document.id);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.pinkAccent[100],
                          child: const Icon(Icons.delete),
                        ),
                        child: ListTile(
                          title: Text(document['title']),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'To-Do-List',
          style: TextStyle(fontWeight: (FontWeight.bold), color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
      ),
      body: _buildBody(context),
    );
  }
}
