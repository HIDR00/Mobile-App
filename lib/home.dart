import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todoitem.dart';
import 'todo.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget{
  Home({Key? key}) : super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  void initState(){
    _foundToDo = toDoList;
    super.initState();
  }
  Widget searchBox() {
    return Container(
      margin: EdgeInsets.only(top: 50,),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
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
            hintStyle: TextStyle(
                color: Color(0xFF717171), height: 1.7, fontSize: 18)
        ),
      ),
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 15,right: 15,left: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          // Implement the stroke
                          Text(
                            'TO DO LIST',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Color(0xFFFF00AD),
                            ),
                          ),
                          Text("TO DO LIST",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      for(ToDo todoo in _foundToDo)
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
        ],
      ),
      floatingActionButton: ElevatedButton(
              child: Text("+",style: TextStyle(fontSize: 40),),
          onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(18),
                primary: Color(0xFFFF00AD),
                minimumSize: Size(40, 40),
                elevation: 10,
              ),
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

  void _runFilter(String enteredKeyWord){
    List<ToDo> results = [];
    if(enteredKeyWord.isEmpty){
      results = toDoList;
    }else{
      results = toDoList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
  void _addTask() async {
    final task = await showDialog<ToDo>(
      context: context,
      builder: (context) => AddTaskDialog(),
    );
    if (task != null) {
      setState(() {
        toDoList.add(task);
      });
    }
  }

}
class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime _deadline = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      backgroundColor: Color(0xFFFDEBED),
      title: Stack(
        alignment: Alignment.topLeft,
        children: [
          // Implement the stroke
          Text(
            'Thêm công việc',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = Color(0xFFFF00AD),
            ),
          ),
          Text('Thêm công việc',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(width: 3,color: Color(0xFFFF00AD))
              ),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Nhập công việc',
                  contentPadding: EdgeInsets.all(0),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 25,
                    minWidth: 25,
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập tiêu đề';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final newDeadline = await showDatePicker(
                  context: context,
                  initialDate: _deadline,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (newDeadline != null) {
                  setState(() {
                    _deadline = newDeadline;
                  });
                }
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text(DateFormat.yMd().format(_deadline)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: ()=> Navigator.of(context).pop(),
            child: Text('Thoát',style: TextStyle(color: Colors.white),)
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final todo = ToDo(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                todoText: _titleController.text,
                deadline: _deadline,
              );
              Navigator.of(context).pop(todo);
            }
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}

