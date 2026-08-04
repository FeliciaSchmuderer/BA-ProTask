import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
       // children: [Checkbox(value: todo.isChecked, onChanged: (value))],
      ),
    );
  }
}
