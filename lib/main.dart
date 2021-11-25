import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/pages/to_do_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListPage(),
    );
  }
}
