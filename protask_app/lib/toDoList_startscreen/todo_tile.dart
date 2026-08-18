import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// displays one single todo item
class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final Function(bool?) onChanged;

  const TodoTile({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // adds space between todos
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      // checkbox - todo item
      child: Row(
        children: [
          // shows current checkbox state
          // passes the user´s change back to TodoScreen
          Checkbox(
            value: todo.isChecked,
            onChanged: onChanged,
          ),

          // space between checkbox and title
          const SizedBox(
            width: 5,
          ),

          // displays todo title
          Text(
            todo.title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
