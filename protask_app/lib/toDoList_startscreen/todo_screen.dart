import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack for title "Today" and date below
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Dienstag, 04.08.2026",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                )
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
              ))
        ],
      ),
    );
  }
}
