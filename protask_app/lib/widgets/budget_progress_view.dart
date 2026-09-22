import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/budget_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';

class BudgetProgressView extends StatelessWidget {
  final int dailyBudget;
  final int taskBudget;
  final int bufferTime;
  final int taskDuration;

  const BudgetProgressView({
    super.key,
    required this.dailyBudget,
    required this.taskBudget,
    required this.bufferTime,
    required this.taskDuration,
  });

  // formatting minutes into hours and minutes
  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) {
      return '${remainingMinutes}m';
    }

    if (remainingMinutes == 0) {
      return '${hours}h';
    }

    return '${hours}h ${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    // calculates how much time is still available within the task budget
    final taskRemaining = (taskBudget - taskDuration).clamp(0, taskBudget);
    // how much of the buffer has already been used
    final bufferUsed = (taskDuration - taskBudget).clamp(0, bufferTime);
    // how much buffer time is still available
    final bufferRemaining = bufferTime - bufferUsed;

    // true when planned task duration is above the normal task budget
    final taskTimeExceeded = taskDuration > taskBudget;
    // true when planned duration exceeds both the task budget and available buffer
    final bufferExceeded = taskDuration > taskBudget + bufferTime;
    // how many minutes the daily budget is exceeded
    final bufferExceededMinutes = taskDuration - (taskBudget + bufferTime);

    // green part of process bar calcualtes how much of the daily budget is reserved for the task budget
    final taskProgress =
        dailyBudget > 0 ? (taskBudget / dailyBudget).clamp(0.0, 1.0) : 0.0;

    // calculates total task duration as percentage
    final taskDurationProgress =
        dailyBudget > 0 ? (taskDuration / dailyBudget).clamp(0.0, 1.0) : 0.0;

    // orange part of progress bar representing the used buffer time
    final overloadProgress = dailyBudget > 0 ? bufferUsed / dailyBudget : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // progress bar showing the planned task time and used buffer time
        ClipRRect(
          borderRadius: BorderRadius.circular(
              QuestionnaireConstants.bufferProcessBarRadius),
          child: SizedBox(
            height: QuestionnaireConstants.bufferProcessBarHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // represents the complete daily budget
                    Container(
                      color: AppThemeConstants.backgroundColor,
                    ),

                    // shows the task time
                    FractionallySizedBox(
                      widthFactor:
                          taskDurationProgress.clamp(0.0, taskProgress),
                      child: Container(
                        color: QuestionnaireConstants.taskProgressColor,
                      ),
                    ),

                    // tasks that exceed the normal task budget and uses the available buffer time
                    if (overloadProgress > 0)
                      Positioned(
                        left: constraints.maxWidth * taskProgress,
                        child: Container(
                          width: constraints.maxWidth * overloadProgress,
                          height: QuestionnaireConstants.bufferProcessBarHeight,
                          color: QuestionnaireConstants.bufferProgressColor,
                        ),
                      ),

                    // border seperating the task budget from the available buffer time
                    FractionallySizedBox(
                      widthFactor: taskProgress,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: QuestionnaireConstants.dateButtonBorderWidth,
                          color: AppThemeConstants.textColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: BudgetConstants.spacingSmall,
        ),

        // displays the planned task time, remaining task time and remianing buffertime below the bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_formatDuration(taskDuration)} / '
              '${_formatDuration(taskBudget)} '
              '${QuestionnaireConstants.taskLabel}',
              style: const TextStyle(
                fontSize: QuestionnaireConstants.bufferwarningTextFontSize,
              ),
            ),
            Text(
              '${_formatDuration(taskRemaining)} '
              '${QuestionnaireConstants.timeLeftLabel}',
              style: const TextStyle(
                fontSize: QuestionnaireConstants.bufferwarningTextFontSize,
              ),
            ),
            Text(
              '${_formatDuration(bufferRemaining)} '
              '${QuestionnaireConstants.bufferLeftLabel}',
              style: const TextStyle(
                fontSize: QuestionnaireConstants.bufferwarningTextFontSize,
              ),
            ),
          ],
        ),

        // displays warning when the task budget is exceeded
        if (taskTimeExceeded) ...[
          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),
          Text(
            // displays another warning the buffer has been completely exceeded
            bufferExceeded
                ? '${QuestionnaireConstants.orangeWarningText}'
                    '${_formatDuration(bufferExceededMinutes)}. '
                    '${QuestionnaireConstants.orangeWarningSuffix}'
                : QuestionnaireConstants.redWarningText,
            style: TextStyle(
              color: bufferExceeded
                  ? QuestionnaireConstants.bufferExceededColor
                  : QuestionnaireConstants.bufferProgressColor,
              fontWeight: AppThemeConstants.subtitleFontWeight,
            ),
          ),
        ],
      ],
    );
  }
}
