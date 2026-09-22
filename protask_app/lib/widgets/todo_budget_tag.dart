import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

class TodoBudgetTag extends StatelessWidget {
  final int? budget;
  final int? timeLeft;
  final VoidCallback onPressed;

  const TodoBudgetTag({
    super.key,
    required this.budget,
    required this.timeLeft,
    required this.onPressed,
  });

  // formatting daily budget in hours and minutes
  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) {
      return '$remainingMinutes min';
    }

    if (remainingMinutes == 0) {
      return '$hours h';
    }

    return '$hours h $remainingMinutes min';
  }

  @override
  Widget build(BuildContext context) {
    final hasBudget = budget != null && budget! > 0;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(
        QuestionnaireConstants.tagBorderRadius,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: QuestionnaireConstants.tagHorizonal,
          vertical: QuestionnaireConstants.tagVertical,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppThemeConstants.borderColor,
          ),
          borderRadius: BorderRadius.circular(
            QuestionnaireConstants.tagBorderRadius,
          ),
        ),
        child: Text(
          hasBudget
              ? 'Budget: ${_formatDuration(budget!)}'
                  ' / ${_formatDuration(timeLeft ?? 0)} left'
              : QuestionnaireConstants.bufferSelectionTextShort,
          style: const TextStyle(
            fontSize: QuestionnaireConstants.tagFontSize,
          ),
        ),
      ),
    );
  }
}
