import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/constants/input_field_constants.dart';

// input field for accomplishments and todoscreen
class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSubmitted;
  final VoidCallback? onQuestionnairePressed;

  const AppInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onSubmitted,
      this.onQuestionnairePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          InputFieldConstants.inputFieldWidthFactor,
      height: InputFieldConstants.inputFieldHeight,
      decoration: BoxDecoration(
        borderRadius: InputFieldConstants.inputFieldBorderRadius,
        color: InputFieldConstants.inputFieldColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: AppConstants.spacingMedium),

          // interactive textfield
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  bottom: InputFieldConstants.contentPaddingBottom,
                ),
                hint: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      InputFieldConstants.addIcon,
                      size: InputFieldConstants.hintIconSize,
                    ),
                    const SizedBox(
                      width: InputFieldConstants.hintSpacing,
                    ),
                    Text(
                      hintText,
                      style: const TextStyle(
                        fontSize: InputFieldConstants.hintFontSize,
                      ),
                    ),
                  ],
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (_) {
                onSubmitted();
              },
            ),
          ),

          // only shows questionnaire button when provided
          if (onQuestionnairePressed != null) ...[
            IconButton(
              onPressed: onQuestionnairePressed,
              icon: const Icon(
                InputFieldConstants.questionnaireIcon,
              ),
            ),
            const SizedBox(
              width: AppConstants.spacingMedium,
            ),
          ],

          // adds entered item
          Padding(
            padding: const EdgeInsets.only(
                right: InputFieldConstants.addTodoIconSpaceRight),
            child: IconButton(
              onPressed: onSubmitted,
              icon: const Icon(InputFieldConstants.addTodoIcon),
            ),
          )
        ],
      ),
    );
  }
}
