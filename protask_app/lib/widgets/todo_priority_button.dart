import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

class TodoPriorityButton extends StatelessWidget {
  final TodoPriority priority;
  final bool isSelected;
  final VoidCallback onPressed;

  const TodoPriorityButton({
    super.key,
    required this.priority,
    required this.isSelected,
    required this.onPressed,
  });

  // button colors
  Color _getPriorityColor() {
    switch (priority) {
      case TodoPriority.a:
        return Colors.red.shade200;
      case TodoPriority.b:
        return Colors.orange.shade200;
      case TodoPriority.c:
        return Colors.yellow.shade200;
      case TodoPriority.d:
        return Colors.blue.shade200;
    }
  }

  Color _getPriorityBorderColor() {
    switch (priority) {
      case TodoPriority.a:
        return Colors.red.shade700;
      case TodoPriority.b:
        return Colors.orange.shade700;
      case TodoPriority.c:
        return Colors.yellow.shade700;
      case TodoPriority.d:
        return Colors.blue.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: _getPriorityColor(),
          border: Border.all(
            color: _getPriorityBorderColor(),
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            priority.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
