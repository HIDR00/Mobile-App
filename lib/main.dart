import 'package:flutter/material.dart';
import 'package:bai_giua_ki/widgets/home.dart';
void main(){
  runApp(myApp());
}
class myApp extends StatelessWidget{
  myApp({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Home(),
    );
  }
}


