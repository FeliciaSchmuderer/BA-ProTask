import 'package:flutter/material.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

class TodoDateButton extends StatelessWidget {
  final String title;
  final DateTime? date;
  final bool isSelected;
  final VoidCallback onPressed;

  const TodoDateButton({
    super.key,
    required this.title,
    required this.date,
    required this.isSelected,
    required this.onPressed,
  });

  String? _formatDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return '${date.day}.${date.month}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: QuestionnaireConstants.dateButtonWidth,
        height: QuestionnaireConstants.dateButtonHeight,
        decoration: BoxDecoration(
          color: isSelected
              ? QuestionnaireConstants.dateSelectedColor
              : QuestionnaireConstants.dateNotSelectedColor,
          border: Border.all(
            color: isSelected
                ? QuestionnaireConstants.dateSelectedColor
                : QuestionnaireConstants.dateNotSelectedBorderColor,
            width: QuestionnaireConstants.dateButtonBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
              QuestionnaireConstants.dateButtonBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: QuestionnaireConstants.dateTitleFontSize,
                fontWeight: QuestionnaireConstants.textFontWeight,
                color: isSelected
                    ? QuestionnaireConstants.dateSelectedTextColor
                    : QuestionnaireConstants.dateNotSelectedTextColor,
              ),
            ),
            if (date != null) ...[
              const SizedBox(
                height: QuestionnaireConstants.dateTextSpacing,
              ),
              Text(
                _formatDate(date)!,
                style: TextStyle(
                  fontSize: QuestionnaireConstants.dateFontSize,
                  color: isSelected
                      ? QuestionnaireConstants.dateSelectedTextColor
                      : QuestionnaireConstants.dateNotSelectedTextColor,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
