import 'package:flutter/material.dart';

class TodolistStartscreen extends StatefulWidget {
  const TodolistStartscreen({super.key});

  @override
  State<TodolistStartscreen> createState() => _TodolistStartscreenState();
}

class _TodolistStartscreenState extends State<TodolistStartscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProTask'),
      ),
      //backgroundColor: Colors.grey,

      // App Menu for navigation
      bottomNavigationBar:
          BottomNavigationBar(
            backgroundColor: Colors.blueGrey,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
        // ToDoList Startscreen
        BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_rounded), label: 'Today'),
        // Weekly and monthly calendar view screens
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        // controll screen
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_rounded),
            label: 'accomplishments'),
        // graphic view screen
        BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined), label: 'Goals'),
        // Eisenhowermatrix but optinal still
        BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Priority'),
      ]),
    );
  }
}
