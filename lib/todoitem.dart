import 'package:bai_giua_ki/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo.dart';
class ToDoItem extends StatelessWidget{
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem ({Key ? key,required this.todo,required this.onDeleteItem,required this.onToDoChanged}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap:(){
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Color(0xFF5F52EE),
        ),
        title: Text(todo.todoText!,style: TextStyle(fontSize: 20,color: todo.isDone ? Colors.green : Color(0xFF3A3A3A))),
        trailing: Container(
          padding: EdgeInsets.all(0), // co hay khong cung duoc
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
            width: 35,
          decoration: BoxDecoration(
            color: Color(0xFFDA4040),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            padding: EdgeInsets.all(5),
            color: Colors.white,
            icon: Icon(Icons.close),
            iconSize: 20,
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}