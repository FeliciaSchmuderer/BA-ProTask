import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/constants/todo_constants.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// displays one single todo item
class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  Color _getPriorityColor() {
    switch (todo.priority) {
      case TodoPriority.a:
        return Colors.red;

      case TodoPriority.b:
        return Colors.orange;

      case TodoPriority.c:
        return Colors.yellow;

      case TodoPriority.d:
        return Colors.green;

      case null:
        return Colors.transparent;
    }
  }

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('dismissible_${todo.id}'),
      direction: DismissDirection.endToStart,

      // displays red field with bin when a todo is deleted
      background: Container(
        alignment: Alignment.centerRight,
        padding: TodoConstants.deleteIconPadding,
        color: TodoConstants.deleteColor,
        child: const Icon(
          TodoConstants.deleteIcon,
          color: AppConstants.iconColor,
        ),
      ),

      onDismissed: (direction) {
        onDelete();
      },

      child: Padding(
        padding: TodoConstants.todoTileBottomSpacing,
        // checkbox - todo item
        child: Row(
          children: [
            // shows current checkbox state
            // passes the user´s change back to parent widget
            Checkbox(
              value: todo.isChecked,
              onChanged: onChanged,
            ),

            // space between checkbox and title
            const SizedBox(
              width: AppConstants.spacingSmall,
            ),

            // displays todo title
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  fontSize: AppConstants.bodyFontSize,
                  decoration: todo.isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),

            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getPriorityColor(),
              ),
            ),

            const SizedBox(width: AppConstants.spacingSmall),
          ],
        ),
      ),
    );
  }
}
