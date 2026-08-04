import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // test todos
  final List<TodoItem> todos = [
    TodoItem(title: "kontrollscreen machen"),
    TodoItem(title: "boden wischen"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack for title "Today" and date below
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "Dienstag, 04.08.2026",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),

                const SizedBox(
                  height: 20,
                ),
                // todo list in the middle of the screen
                Expanded(
                  child: TodoList(
                    todos: todos,
                  ),
                ),
              ],
            ),
          ),

          // Container for layout for textbox on the bottom for adding todos (+ add task)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[350],
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.add),
                  Text(
                    "Add Task",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
