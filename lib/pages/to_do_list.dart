import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void addTask() {
    FirebaseFirestore.instance
        .collection('todos')
        .add({"title": _controller.text});
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Type here'),
              ),
            ),
            TextButton(
              onPressed: () {
                addTask();
              },
              child: Text('Add task'),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('todos').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return ListTile(
                        title: Text(document['title']),
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
      appBar: AppBar(
        title: Text('ToDoList'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }
}
