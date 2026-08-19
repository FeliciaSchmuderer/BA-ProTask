import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// Central logic for all todos
// Today and Accomplishment get their todos from this same TodoProvider
class TodoProvider extends ChangeNotifier {
  // private list of all todos
  final List<TodoItem> _todos = [];

  int _nextId = 0;

  // Gives screens access to the todos without allowing them to directly replace or modify the list
  // Returns all unfinished todos first and completed at the bottom
  List<TodoItem> get todos {
    // copy to save the original _todos list
    final sortedTodos = List<TodoItem>.from(_todos);

    sortedTodos.sort((a, b) {
      // if both todos have the same status the current order stays the same
      if (a.isChecked == b.isChecked) {
        if (!a.isChecked) {
          return 0;
        }

        // if both are completed the most recently completed todo comes at first
        if (a.completedAt == null || b.completedAt == null) {
          return 0;
        }

        return b.completedAt!.compareTo(a.completedAt!);
      }

      // a checked todo gets moved to the bottom
      return a.isChecked ? 1 : -1;
    });

    // return the sorted list; List.unmodifiable prevents other classes from changing the list dirctly
    return List.unmodifiable(sortedTodos);
  }

  // adds a normal todo to the central list
  void addTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _todos.add(
      TodoItem(
        id: _nextId++,
        title: title.trim(),
      ),
    );

    // tells all listening screens that data has changed
    notifyListeners();
  }

  // changes the completed state of a todo
  void toggleTodo(TodoItem todo, bool value) {
    // changes selected todo directly
    todo.isChecked = value;

    if (value) {
      // saves current time to know which todo was completed at first for sorting the completed todos
      todo.completedAt = DateTime.now();
    } else {
      // unchecked -> todo is no longer considered completed
      todo.completedAt = null;
    }

    notifyListeners();
  }

  // deletes a todo
  void deleteTodo(TodoItem todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  // adds a todo that is already completed when it is added in accomplishments
  void addCompletedTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _todos.add(
      TodoItem(
        // gives manually added accomplishments also an id
        id: _nextId++,
        title: title.trim(),
        isChecked: true,

        // for sorting completed todos
        completedAt: DateTime.now(),
      ),
    );

    // updates all screens that are watching the provider
    notifyListeners();
  }
}
