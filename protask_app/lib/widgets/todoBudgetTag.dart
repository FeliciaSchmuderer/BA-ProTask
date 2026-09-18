import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

class Todobudgettag extends StatelessWidget {
  final int? budget;
  final VoidCallback onPressed;

  const Todobudgettag({
    super.key,
    required this.budget,
    required this.onPressed,
  });

  // formatting daily budget in hours and minutes
  String _formatBudget() {
    if (budget == null || budget! <= 0) {
      return QuestionnaireConstants.bufferSelectionTextShort;
    }

    final hours = budget! ~/ 60;
    final minutes = budget! % 60;

    if (hours == 0) {
      return '$minutes min';
    }

    if (minutes == 0) {
      return '$hours h';
    }

    return '$hours h $minutes min';
  }

  @override
  Widget build(BuildContext context) {
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
          'Budget: ${_formatBudget()}',
          style: const TextStyle(
            fontSize: QuestionnaireConstants.tagFontSize,
          ),
        ),
      ),
    );
  }
}
