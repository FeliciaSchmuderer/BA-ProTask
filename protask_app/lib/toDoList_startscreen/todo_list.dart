import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class TodoList extends StatelessWidget {
  // list of all todo items
  final List<TodoItem> todos;
  // Function to update the state of a todo (checked or not)
  final Function(bool?, TodoItem) onChanged;
  // function to delete a todo
  final Function(TodoItem) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    
    // scrollable list of todo tiles
    return ListView.builder(

      padding: const EdgeInsets.only(bottom: 90),
    
      itemCount: todos.length,

      // builds each todo item
      itemBuilder: (context, index) {
        return TodoTile(
          // passes current todo item to title
          todo: todos[index],

          // sends checkbox changes back to TodoScreen
          onChanged: (value) {
            onChanged(value, todos[index]);
          },

          onDelete: () {
            onDelete(todos[index]);
          },
        );
      },
    );
  }
}
