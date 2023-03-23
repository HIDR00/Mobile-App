import 'package:bai_giua_ki/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:intl/intl.dart';
class ToDoItem extends StatelessWidget{
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem ({Key ? key,required this.todo,required this.onDeleteItem,required this.onToDoChanged}) : super(key: key);
  @override
  Widget build(BuildContext context){
    bool isOverdue = DateTime.now().isAfter(todo.deadline);
    Color? tileColor;
    if ((isOverdue && todo.isDone)) {
      tileColor = Colors.white;
    } else if(isOverdue){
      tileColor = Colors.red[100];
    }else {
      tileColor = Colors.white;
    }
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
        tileColor: tileColor,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Color(0xFFFF00AD),
        ),
        title: Text(todo.todoText!,style: TextStyle(fontSize: 20,color: todo.isDone ? Colors.green : Color(0xFF3A3A3A))),
        subtitle:
        Text('Deadline: ${DateFormat.yMd().format(todo.deadline)}'),
        trailing: Container(
          padding: EdgeInsets.all(0), // co hay khong cung duoc
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Color(0xFFE40327),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF950018))
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