import 'package:flutter/material.dart';
import 'package:hello_flutter/movie/list/movie_list_page.dart';

// Entrance
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hello Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MovieListPage(),
    );
  }
}