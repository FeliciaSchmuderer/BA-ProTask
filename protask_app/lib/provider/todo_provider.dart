import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// Central logic for all todos
// Today and Accomplishment get their todos from this same TodoProvider
class TodoProvider extends ChangeNotifier {
  // private list of all todos
  final List<TodoItem> _openTodos = [];
  final List<TodoItem> _completedTodos = [];

  int _nextId = 0;

  // Gives screens access to the todos without allowing them to directly replace or modify the list
  // Returns all unfinished todos first and completed at the bottom
  List<TodoItem> get todos {
    // return the sorted list; List.unmodifiable prevents other classes from changing the list dirctly
    return List.unmodifiable([..._openTodos, ..._completedTodos]);
  }

// GETTER
//to access once open and completed todos

  List<TodoItem> get openTodos {
    return List.unmodifiable(_openTodos);
  }

  List<TodoItem> get completedTodos {
    return List.unmodifiable(_completedTodos);
  }

  // adds an open todo
  void addTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _openTodos.add(
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
    if (value) {
      // todo gets completed
      _openTodos.remove(todo);

      todo.isChecked = true;
      todo.completedAt = DateTime.now();

      _completedTodos.add(todo);
    } else {
      // todo is reopened
      _completedTodos.remove(todo);

      todo.isChecked = false;
      todo.completedAt = null;

      _openTodos.add(todo);
    }

    notifyListeners();
  }

  // deletes a todo
  void deleteTodo(TodoItem todo) {
    _openTodos.remove(todo);
    _completedTodos.remove(todo);

    notifyListeners();
  }

  // changes position of todo after dragging
  // only open todos can be rearranged
  void reorderTodo(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _openTodos.length) {
      return;
    }

    if (newIndex > oldIndex) {
      newIndex--;
    }

// new index minimum position
    if (newIndex < 0) {
      newIndex = 0;
    }

// new index maximum position
    if (newIndex > _openTodos.length) {
      newIndex = _openTodos.length;
    }

    final todo = _openTodos.removeAt(oldIndex);
    _openTodos.insert(newIndex, todo);

    notifyListeners();
  }

  // adds a todo that is already completed when it is added in accomplishments
  void addCompletedTodo(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _completedTodos.add(
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
