import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final Function(bool?) onChanged;

  const TodoTile({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Checkbox(
            value: todo.isChecked,
            onChanged: onChanged,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            todo.title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
