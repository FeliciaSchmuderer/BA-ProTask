import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
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

  // returns button colors
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: QuestionnaireConstants.priorityButtonHeight,
        width: QuestionnaireConstants.priorityButtonWidth,
        decoration: BoxDecoration(
          // highlight button with a light priority color when selected
          color: isSelected
              ? _getPriorityColor().withValues(alpha: 0.15)
              : AppThemeConstants.popupColor,
          border: Border.all(
            color: _getPriorityColor(),
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
            style: TextStyle(
              fontSize: QuestionnaireConstants.priorityFontSize,
              fontWeight: QuestionnaireConstants.textFontWeight,
              color: isSelected
                  ? _getPriorityColor()
                  : AppThemeConstants.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
