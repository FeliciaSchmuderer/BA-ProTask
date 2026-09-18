import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

// tag for display deadline date and time on todotile
class TodoDeadlineTag extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;

  const TodoDeadlineTag({
    super.key,
    required this.date,
    required this.time,
  });

  // formatting date as DD.MM.
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month.';
  }

  // formatting time as HH:MM
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    // stores available deadline parts for display
    final parts = <String>[];

    // adds date if deadline date was selected
    if (date != null) {
      parts.add(_formatDate(date!));
    }

    // adds time if deadline time was selected
    if (time != null) {
      parts.add(_formatTime(time!));
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: QuestionnaireConstants.tagHorizonal,
        vertical: QuestionnaireConstants.tagVertical,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppThemeConstants.borderColor,
        ),
        borderRadius:
            BorderRadius.circular(QuestionnaireConstants.tagBorderRadius),
      ),
      // separate date and time with two spaces
      child: Text(
        parts.join('  '),
        style: const TextStyle(
          fontSize: QuestionnaireConstants.tagFontSize,
        ),
      ),
    );
  }
}
