import 'package:flutter/material.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

class TodoDeadlineButton extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;
  final String text;
  final VoidCallback onPressed;

  const TodoDeadlineButton({
    super.key,
    required this.date,
    required this.time,
    required this.text,
    required this.onPressed,
  });

  // formatting date for display
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month';
  }

  // formatting time for display
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = text;

    if (date != null) {
      buttonText = _formatDate(date!);
    } else if (time != null) {
      buttonText = _formatTime(time!);
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: QuestionnaireConstants.deadlineButtonWidth,
        height: QuestionnaireConstants.deadlineButtonHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: QuestionnaireConstants.deadlineButtonBorderColor,
            width: QuestionnaireConstants.deadlineButtonBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
            QuestionnaireConstants.deadlineButtonBorderRadius,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: QuestionnaireConstants.deadlineButtonFontSize,
              fontWeight: QuestionnaireConstants.textFontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
