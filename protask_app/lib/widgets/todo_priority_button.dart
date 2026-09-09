import 'package:flutter/material.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
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
        return QuestionnaireConstants.priorityAColor;
      case TodoPriority.b:
        return QuestionnaireConstants.priorityBColor;
      case TodoPriority.c:
        return QuestionnaireConstants.priorityCColor;
      case TodoPriority.d:
        return QuestionnaireConstants.priorityDColor;
    }
  }

  Color _getPriorityBorderColor() {
    switch (priority) {
      case TodoPriority.a:
        return QuestionnaireConstants.priorityABorderColor;
      case TodoPriority.b:
        return QuestionnaireConstants.priorityBBorderColor;
      case TodoPriority.c:
        return QuestionnaireConstants.priorityCBorderColor;
      case TodoPriority.d:
        return QuestionnaireConstants.priorityDBorderColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: QuestionnaireConstants.priorityButtonHeight,
        width: QuestionnaireConstants.priorityButtonWidth,
        decoration: BoxDecoration(
          color: _getPriorityColor(),
          border: Border.all(
            color: _getPriorityBorderColor(),
            width: isSelected
                ? QuestionnaireConstants.prioritySelectedButtonBorderWidth
                : QuestionnaireConstants.priorityButtonBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
              QuestionnaireConstants.priorityButtonBorderRadius),
        ),
        child: Center(
          child: Text(
            priority.name.toUpperCase(),
            style: const TextStyle(
              fontSize: QuestionnaireConstants.priorityFontSize,
              fontWeight: QuestionnaireConstants.textFontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
