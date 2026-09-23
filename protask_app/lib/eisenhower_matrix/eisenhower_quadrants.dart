import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/eisenhower_constants.dart';
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
        minHeight: EisenhowerConstants.quadrantMinHeight,
      ),
      padding: const EdgeInsets.all(EisenhowerConstants.quadrantPadding),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius:
            BorderRadius.circular(EisenhowerConstants.quadrantBorderRadius),
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
                width: EisenhowerConstants.priorityMarkerSize,
                height: EisenhowerConstants.priorityMarkerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: priorityColor,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: EisenhowerConstants.quadrantPadding,
          ),

          // diplays the todos of the quadrants
          ...todos.map(
            (todo) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: todo.isChecked,
                      onChanged: (value) {
                        if (value != null) {
                          todoProvider.toggleTodo(todo, value);
                        }
                      },
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),

                    const SizedBox(
                      width: 2,
                    ),
                    // todo title
                    Expanded(
                      child: Text(
                        todo.title,
                        style: const TextStyle(
                          fontSize: EisenhowerConstants.todoFontSize,
                          fontWeight: EisenhowerConstants.todoFontWeight,
                        ),
                      ),
                    ),
                  ],
                ),

                // estimated duration
                if (todo.estimatedDuration != null ||
                    todo.deadlineDate != null ||
                    todo.deadlineTime != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: EisenhowerConstants.todoTagsLeftPadding),
                    child: Wrap(
                      spacing: AppThemeConstants.spacingMini,
                      runSpacing: EisenhowerConstants.tagRunSpacing,
                      children: [
                        // estimated duration
                        if (todo.estimatedDuration != null)
                          TodoDurationTag(
                            duration: todo.estimatedDuration!,
                          ),

                        // spacing between tags
                        if (todo.estimatedDuration != null &&
                            (todo.deadlineDate != null ||
                                todo.deadlineTime != null))
                          const SizedBox(
                            width: AppThemeConstants.spacingMini,
                          ),

                        // deadline
                        if (todo.deadlineDate != null ||
                            todo.deadlineTime != null)
                          TodoDeadlineTag(
                            date: todo.deadlineDate,
                            time: todo.deadlineTime,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
