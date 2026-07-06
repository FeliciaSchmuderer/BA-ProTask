import 'package:flutter/material.dart';

class TodolistStartscreen extends StatefulWidget {
  const TodolistStartscreen({super.key});

  @override
  State<TodolistStartscreen> createState() => _TodolistStartscreenState();
}

class _TodolistStartscreenState extends State<TodolistStartscreen> {
  //lower app menu

  // stores the index of the currently selected item
  // default value 0 shows 'Today' screen
  int _selectedIndex = 0;

  // list of widgets for bottom navigation items
  // placeholder widgets -> later screens
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Today'),
    Text('Index 1: Calendar'),
    Text('Index 2: Accomplishments'),
    Text('Index 3: Goals'),
    Text('Index 4: Priorities'),
  ];

  // updates the selected navigation item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProTask'),
      ),
      //backgroundColor: Colors.grey,

      // App Menu for navigation
      body: Center(
        // shows widget responding to the selected navigation item
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
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
        ],
        // currently selected navigation item
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        // when item is tapped on it switches to the selected one
        onTap: _onItemTapped,
      ),
    );
  }
}
