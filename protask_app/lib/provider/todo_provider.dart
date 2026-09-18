import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

// central state logic for all todos
//
// Today and Accomplishment get their todos from this same TodoProvider
class TodoProvider extends ChangeNotifier {
  // central private lists of open and completed todos to divide them in startscreen
  final List<TodoItem> _openTodos = [];
  final List<TodoItem> _completedTodos = [];

  // used to give every todo a unique ID
  int _nextId = 0;

  TodoProvider() {
    _loadTodos();
  }

  // STORAGE
  //
  // saves all todos locally
  Future<void> _saveTodos() async {
    final preferences = await SharedPreferences.getInstance();

    final openTodosJson =
        _openTodos.map((todo) => jsonEncode(todo.toJson())).toList();

    final completedTodosJson =
        _completedTodos.map((todo) => jsonEncode(todo.toJson())).toList();

    await preferences.setStringList(
      'openTodos',
      openTodosJson,
    );

    await preferences.setStringList(
      'completedTodos',
      completedTodosJson,
    );

    await preferences.setInt(
      'nextId',
      _nextId,
    );
  }

  // loads all saved todos
  Future<void> _loadTodos() async {
    final preferences = await SharedPreferences.getInstance();

    final openTodosJson = preferences.getStringList('openTodos') ?? [];

    final completedTodosJson =
        preferences.getStringList('completedTodos') ?? [];

    _openTodos.clear();
    _completedTodos.clear();

    _openTodos.addAll(
      openTodosJson.map(
        (todo) => TodoItem.fromJson(jsonDecode(todo)),
      ),
    );

    _completedTodos.addAll(
      completedTodosJson.map(
        (todo) => TodoItem.fromJson(jsonDecode(todo)),
      ),
    );

    _nextId = preferences.getInt('nextId') ?? 0;

    notifyListeners();
  }

  // List.unmodifiable prevents other classen from modifying the providers internal list directly
  // return all open todos
  List<TodoItem> get openTodos {
    return List.unmodifiable(_openTodos);
  }

  // returns all completed todos
  List<TodoItem> get completedTodos {
    return List.unmodifiable(_completedTodos);
  }

  // adds a new open todo
  Future<void> addTodo(
    String title, {
    DateTime? scheduledDate,
    DateTime? deadlineDate,
    TimeOfDay? deadlineTime,
    TodoPriority? priority,
    int? estimatedDuration,
  }) async {
    if (title.trim().isEmpty) {
      return;
    }

    _openTodos.add(
      TodoItem(
        id: _nextId++,
        title: title.trim(),
        scheduledDate: scheduledDate,
        deadlineDate: deadlineDate,
        deadlineTime: deadlineTime,
        priority: priority,
        estimatedDuration: estimatedDuration,
      ),
    );
    await _saveTodos();
    notifyListeners();
  }

  // changes the completed state of a todo
  Future<void> toggleTodo(TodoItem todo, bool value) async {
    if (value) {
      // when todo gets completed todo moves from open to completed
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
    await _saveTodos();
    notifyListeners();
  }

  // deletes a todo from open todo and accomplishment lists
  Future<void> deleteTodo(TodoItem todo) async {
    _openTodos.remove(todo);
    _completedTodos.remove(todo);

    await _saveTodos();
    notifyListeners();
  }

  // changes position of todo after dragging
  // only open todos can be rearranged
  Future<void> reorderTodo(int oldIndex, int newIndex) async {
    if (oldIndex < 0 || oldIndex >= _openTodos.length) {
      return;
    }

    final todo = _openTodos.removeAt(oldIndex);

    // new index minimum position
    if (newIndex < 0) {
      newIndex = 0;
    }

    // new index maximum position
    if (newIndex > _openTodos.length) {
      newIndex = _openTodos.length;
    }

    _openTodos.insert(newIndex, todo);

    await _saveTodos();
    notifyListeners();
  }

  // adds a todo that is already completed when it is added in accomplishment screen
  Future<void> addCompletedTodo(
    String title, {
    DateTime? completedAt,
  }) async {
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
        completedAt: completedAt ?? DateTime.now(),
      ),
    );
    await _saveTodos();
    notifyListeners();
  }
}
