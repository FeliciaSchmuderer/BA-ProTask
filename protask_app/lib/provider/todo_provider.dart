import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoItem> _todos = [
    TodoItem(title: "bambi gassi"),
    TodoItem(title: "Boden wischen"),
  ];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _todos.add(
      TodoItem(
        title: title.trim(),
      ),
    );

    notifyListeners();
  }

  void toggleTodo(int index, bool value) {
    _todos[index].isChecked = value;
    notifyListeners();
  }

  void addCompletedTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _todos.add(
      TodoItem(
        title: title.trim(),
        isChecked: true,
      ),
    );

    notifyListeners();
  }
}
