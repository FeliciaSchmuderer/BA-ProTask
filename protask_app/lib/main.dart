import 'package:flutter/material.dart';
import 'package:protask_app/navigation/navigation_screen.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // allows Today and Accomplishments to use the same todo list saved in TodoProvider and makes it available to all screens below M
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationScreen(),
    );
  }
}
