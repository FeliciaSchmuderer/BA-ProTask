import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// displays one single todo item
class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // adds space between todos
    return Dismissible(
      key: ValueKey(todo),
      direction: DismissDirection.endToStart,

      // displays red field with bin when a todo is deleted
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: Padding(
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
      ),
    );
  }
}
