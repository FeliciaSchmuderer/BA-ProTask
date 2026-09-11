import 'package:flutter/material.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

// tag for display on todotile
class TodoDeadlineTag extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;

  const TodoDeadlineTag({
    super.key,
    required this.date,
    required this.time,
  });

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month.';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];

    if (date != null) {
      parts.add(_formatDate(date!));
    }

    if (time != null) {
      parts.add(_formatTime(time!));
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: QuestionnaireConstants.deadlineTagHorizonal,
        vertical: QuestionnaireConstants.deadlineTagVertical,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: QuestionnaireConstants.buttonBorderColor,
        ),
        borderRadius:
            BorderRadius.circular(QuestionnaireConstants.buttonBorderRadius),
      ),
      child: Text(
        parts.join('  '),
        style: const TextStyle(
          fontSize: QuestionnaireConstants.deadlineButtonFontSize,
        ),
      ),
    );
  }
}
