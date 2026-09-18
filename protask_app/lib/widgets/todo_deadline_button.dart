import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
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

    return SizedBox(
      width: QuestionnaireConstants.deadlineButtonWidth,
      height: QuestionnaireConstants.deadlineButtonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: QuestionnaireConstants.qButtonFontSize,
            fontWeight: QuestionnaireConstants.textFontWeight,
            color: AppThemeConstants.textColor,
           
          ),
        ),
      ),
      ),
    );
  }
}
