import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todoitem.dart';
import 'todo.dart';


class Home extends StatefulWidget{
  Home({Key? key}) : super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = ToDo.todoList();
  final _toDoController = TextEditingController();
  // list<ToDo> _foundToDo = [];
  var mySearchBox = Container(
    margin: EdgeInsets.only(top: 50,),
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF3A3A3A), //Colors.black,
            size: 30,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Color(0xFF717171),height: 1.7,fontSize: 18)
      ),
    ),
  );

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 15,right: 15,left: 15),
            child: Column(
              children: [
                mySearchBox,
                Expanded(
                  child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 0,
                        bottom: 20,
                      ),
                      child: Text("All to do",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  for(ToDo todoo in toDoList)
                  ToDoItem(todo: todoo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  ),
                  ],
                ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:  Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.all(7),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                    ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                      hintText: "add new todo item",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    bottom: 10,
                  ),
                  child: ElevatedButton(
                    child: Text("+",style: TextStyle(fontSize: 40),),
                    onPressed: (){
                      _addToDoItem(_toDoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(18),
                      primary: Color(0xFF5F52EE),
                      minimumSize: Size(40, 40),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void _deleteToDoItem(String id){
    setState(() {
      toDoList.removeWhere((element) => element.id == id);
    });
  }
  void _addToDoItem(String toDo){
    setState(() {
      toDoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),todoText: toDo));
    });
    _toDoController.clear();
  }
}


