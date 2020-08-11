import 'package:flutter/material.dart';
import 'package:posts_app/pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
            headline6: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.blue[900])),
        primarySwatch: Colors.blue,
      ),
      home: Homepage(
        title: "Posts",
      ),
    );
  }
}
