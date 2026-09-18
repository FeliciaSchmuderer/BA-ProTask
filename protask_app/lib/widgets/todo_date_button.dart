import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_responsive.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
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

  // formats date for display
  String? _formatDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return '${date.day}.${date.month}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppResponsive.size(
        context,
        QuestionnaireConstants.dateButtonHeight,
      ),
      // changes appearance depending on selection
      child: OutlinedButton(
        onPressed: onPressed,
        style: isSelected
            ? OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppThemeConstants.accentColor,
                  width: QuestionnaireConstants.dateButtonBorderWidth,
                ),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title == QuestionnaireConstants.dateTextPick && date != null ? _formatDate(date)! : title,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppResponsive.size(
                  context,
                  QuestionnaireConstants.qButtonFontSize,
                ),
                fontWeight: QuestionnaireConstants.textFontWeight,
                color: AppThemeConstants.textColor,
              ),
            ),

            // only shows a date when one is available
            if (date != null && title != QuestionnaireConstants.dateTextPick) ...[
              SizedBox(
                height: AppResponsive.size(
                  context,
                  QuestionnaireConstants.dateTextSpacing,
                ),
              ),
              Text(
                _formatDate(date)!,
                style: TextStyle(
                  fontSize: AppResponsive.size(context, QuestionnaireConstants.qButtonFontSize,),
                  color: AppThemeConstants.textColor,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
