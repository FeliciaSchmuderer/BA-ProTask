import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

// button for displaying and selecting a todo duration
class TodoDurationButton extends StatelessWidget {
  final int? duration;
  final VoidCallback onPressed;

  const TodoDurationButton({
    super.key,
    required this.duration,
    required this.onPressed,
  });

  // formatting duration in minutes as hours and minutes for the button text
  String get _durationText {
    // default text when no valid duration is selected
    if (duration == null || duration! <= 0) {
      return QuestionnaireConstants.durationTextPick;
    }

    final hours = duration! ~/ 60;
    final minutes = duration! % 60;

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
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(
          QuestionnaireConstants.deadlineButtonWidth,
          QuestionnaireConstants.deadlineButtonHeight,
        ),
        side: const BorderSide(
          color: AppThemeConstants.borderColor,
          width: QuestionnaireConstants.deadlineButtonBorderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            QuestionnaireConstants.deadlineButtonBorderRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          _durationText,
          style: const TextStyle(
            fontSize: QuestionnaireConstants.qButtonFontSize,
            color: AppThemeConstants.textColor,
          ),
        ),
      ),
    );
  }
}
