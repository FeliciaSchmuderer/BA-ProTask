import 'package:flutter/material.dart';
import 'package:protask_app/accomplishments/accomplishments_screen.dart';
import 'package:protask_app/calendar/calendar_screen.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/eisenhower_matrix/eisenhower_screen.dart';
import 'package:protask_app/todoList_startscreen/todo_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  //lower app menu

  // stores the index of the currently selected navigation item
  int _selectedIndex = 0;

  // list of widgets for bottom navigation items
  //-> screens for navigations
  final List<Widget> _pages = [
    const TodoScreen(),
    const CalendarScreen(),
    const AccomplishmentsScreen(),
    // const GoalsScreen(),

   /* const Center(
      child: Text("Goals"),
    ),*/

    const EisenhowerScreen(),
  ];

  // list of widgets for bottom navigation items
  // updates the selected page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppThemeConstants.appBarTitle),
        centerTitle: true,
      ),

      // App Menu for navigation
      // reference to screens
      body: _pages[_selectedIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: AppThemeConstants.barBorderRadius,
        child: BottomNavigationBar(
          backgroundColor: AppThemeConstants.appBarColor,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            // TodoList Startscreen
            BottomNavigationBarItem(
                icon: Icon(AppThemeConstants.todayIcon),
                label: AppThemeConstants.todayLabel),
            // Weekly and monthly calendar view screens
            BottomNavigationBarItem(
              icon: Icon(AppThemeConstants.calendarIcon),
              label: AppThemeConstants.calendarLabel,
            ),
            // controll screen
            BottomNavigationBarItem(
                icon: Icon(AppThemeConstants.accomplishmentIcon),
                label: AppThemeConstants.accomplishmentLabel),
         

         /*   // graphic view screen
            BottomNavigationBarItem(
                icon: Icon(AppThemeConstants.graphicIcon),
                label: AppThemeConstants.graphicLabel),
                */


            // Eisenhowermatrix
            BottomNavigationBarItem(
                icon: Icon(AppThemeConstants.priorityIcon),
                label: AppThemeConstants.priorityLabel),
          ],
          // currently selected navigation item
          currentIndex: _selectedIndex,
          selectedItemColor: AppThemeConstants.accentColor,
          // when item is tapped on it switches to the selected one
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
