import 'package:flutter/cupertino.dart';

class ToDo{
  String? id;
  String? todoText;
  final DateTime deadline;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    required this.deadline,
    this.isDone = false,
  });
  static List<ToDo> todoList(){
    return [

    ];
  }
}