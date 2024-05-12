import 'package:to_do_app/model/todo.dart';

import 'package:flutter/material.dart';
import './widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoController = TextEditingController();
  List<ToDo> foundToDo = [];
  final todosList = ToDo.todosList();
  @override
  void initState() {
    // TODO: implement initState
    foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          back(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(children: [
                Expanded(
                    child: ListView(
                  children: [
                    for (ToDo todoo in foundToDo)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: delToDo,
                      ),
                  ],
                )),
              ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add a new TODO', border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        addToDo(todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Color.fromARGB(255, 10, 1, 12),
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void delToDo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDo(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    todoController.clear();
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 33, 1, 50),
    elevation: 20,
    shadowColor: Color.fromARGB(255, 8, 0, 11),
    title: Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      child: const Text(
        'ToDo App',
        style: TextStyle(
            color: Color.fromARGB(244, 234, 234, 234),
            fontSize: 30,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget back() {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromARGB(223, 220, 23, 207),
      Color.fromARGB(199, 67, 8, 94)
    ])),
  );
}
