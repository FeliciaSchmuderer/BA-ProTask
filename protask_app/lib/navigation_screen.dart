import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  //lower app menu

  // stores the index of the currently selected item
  // default value 0 shows 'Today' screen
  int _selectedIndex = 0;

  // list of widgets for bottom navigation items
  //-> screens for navigations
  final List<Widget> _pages = [
    const TodoScreen(),
    // const CalendarScreen(),
    // const AccomplishmentsScreen(),
    // const GoalsScreen(),
    // const PriorityScreen(),
  ];

  // list of widgets for bottom navigation items

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
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 9),
          child: Icon(Icons.menu_rounded, size: 35),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 15, top: 2),
              child: Icon(Icons.account_circle_rounded, size: 40)),
        ],
      ),
      //backgroundColor: Colors.grey,

      // App Menu for navigation
      // reference to screens
      body: _pages[_selectedIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.elliptical(15, 5),
          topRight: Radius.elliptical(15, 5),
        ),
        child: BottomNavigationBar(
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
      ),
    );
  }
}
