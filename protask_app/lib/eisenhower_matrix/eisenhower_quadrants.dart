import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';

class EisenhowerQuadrants extends StatelessWidget {
  final String title;
  final List<TodoItem> todos;

  const EisenhowerQuadrants({
    super.key,
    required this.title,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 180,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title of quadrant
          Text(
            title,
            style: const TextStyle(
              fontSize: AppThemeConstants.subtitleFontSize,
              fontWeight: AppThemeConstants.subtitleFontWeight,
            ),
          ),

          const SizedBox(height: 10),

          // diplays the todos of the quadrants
          ...todos.map(
            (todo) => Text(
              todo.title,
              style: const TextStyle(
                fontSize: 12, // AppThemeConstants ??
              ),
            ),
          ),
        ],
      ),
    );
  }
}
