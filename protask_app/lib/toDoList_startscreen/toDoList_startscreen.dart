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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_rounded),
            label: 'Today'),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
            ),

          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_rounded),
            label: 'accomplishments'),

          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: 'Goals'),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Priority'),
        ]),
    );
  }
}