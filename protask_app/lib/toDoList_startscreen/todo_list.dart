import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class TodoList extends StatelessWidget {
  final List<TodoItem> todos;
  final Function(bool?, int) onChanged;

  const TodoList({
    super.key,
    required this.todos,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(
          todo: todos[index],
          onChanged: (value) {
            onChanged(value, index);
          },
        );
      },
    );
  }
}
