import 'package:flutter/material.dart';

class page1 extends StatefulWidget {
  @override
  page1State createState() => page1State();
}

class page1State extends State<page1>{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TO DO LIST"),
        ),
      ),
    );
  }
}