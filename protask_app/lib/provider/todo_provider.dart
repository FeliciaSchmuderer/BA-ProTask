import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// Central logic for all todos
// Today and Accomplishment get their todos from this same TodoProvider
class TodoProvider extends ChangeNotifier {
  // private list of all todos
  final List<TodoItem> _todos = [];

  // Gives screens access to the todos without allowing them to directly replace or modify the list
  List<TodoItem> get todos => List.unmodifiable(_todos);

  // adds a normal todo to the central list
  void addTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _todos.add(
      TodoItem(
        title: title.trim(),
      ),
    );

    // tells all listening screens that data has changed
    notifyListeners();
  }

  // changes the completed state of a todo
  void toggleTodo(int index, bool value) {
    _todos[index].isChecked = value;
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
        title: title.trim(),
        isChecked: true,
      ),
    );

    // updates all screens that are watching the provider
    notifyListeners();
  }
}
