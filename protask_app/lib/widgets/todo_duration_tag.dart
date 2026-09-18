import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

// displays todo duration as tag
class TodoDurationTag extends StatelessWidget {
  final int duration;

  const TodoDurationTag({
    super.key,
    required this.duration,
  });

  // formatting duration in minutes as hours and minutes
  String _formatDuration() {
    final hours = duration ~/ 60;
    final minutes = duration % 60;

    if (minutes == 0) {
      return '$hours h';
    }

    if (hours == 0) {
      return '$minutes min';
    }

    return '$hours h $minutes min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time,
              size: 15,
              color: AppThemeConstants.textColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              _formatDuration(),
              style: const TextStyle(
                fontSize: QuestionnaireConstants.tagFontSize,
              ),
            ),
          ],
        ));
  }
}
