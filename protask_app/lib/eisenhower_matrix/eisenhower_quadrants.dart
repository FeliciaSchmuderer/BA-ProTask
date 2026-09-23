import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';
import 'package:protask_app/widgets/todo_deadline_tag.dart';
import 'package:protask_app/widgets/todo_duration_tag.dart';
import 'package:provider/provider.dart';

class EisenhowerQuadrants extends StatelessWidget {
  final String title;
  final List<TodoItem> todos;
  final Color priorityColor;

  const EisenhowerQuadrants({
    super.key,
    required this.title,
    required this.todos,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();

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
          Row(
            children: [
              Expanded(
                // title of quadrant
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppThemeConstants.subtitleFontSize,
                    fontWeight: AppThemeConstants.subtitleFontWeight,
                  ),
                ),
              ),

              // priority marker
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: priorityColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // diplays the todos of the quadrants
          ...todos.map(
            (todo) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  // checkbox
                  Checkbox(
                    value: todo.isChecked,
                    onChanged: (value) {
                      if (value != null) {
                        todoProvider.toggleTodo(todo, value);
                      }
                    },
                  ),

                  const SizedBox(
                    width: 4,
                  ),

                  // todo title
                  Expanded(
                    child: Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: AppThemeConstants.bodyFontSize,
                      ),
                    ),
                  ),

                  // estimated duration
                  if (todo.estimatedDuration != null) ...[
                    TodoDurationTag(
                      duration: todo.estimatedDuration!,
                    ),
                    const SizedBox(
                      width: AppThemeConstants.spacingSmall,
                    ),
                  ],

                  // deadline
                  if (todo.deadlineDate != null || todo.deadlineTime != null)
                    TodoDeadlineTag(
                      date: todo.deadlineDate,
                      time: todo.deadlineTime,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
