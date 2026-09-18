import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/widgets/todo_duration_button.dart';
import 'package:provider/provider.dart';

class BufferSection extends StatelessWidget {
  final DateTime? selectedDate;
  final int? selectedDuration;

  const BufferSection({
    super.key,
    required this.selectedDate,
    required this.selectedDuration,
  });

  // open duration picker for daily budget selection
  Future<void> _pickDailyBudget(BuildContext context) async {
    final date = selectedDate;

    // budget can only be selected when a day has been selected
    if (date == null) {
      return;
    }

    final budgetProvider = context.read<DailyBudgetProvider>();

    // gets currently selected budget to be shown as the initial value in the duration picker
    final currentBudget = budgetProvider.getBudget(date);

    final selectedBudget = await AppDurationPicker.selectDuration(
      context,
      currentBudget,
    );

    // do nothing if the user closes the picker without selecting a value
    if (selectedBudget == null) {
      return;
    }

    // selecting 0 removes the budget for the day
    if (selectedBudget == 0) {
      await budgetProvider.removeBudget(date);
      return;
    }

    // saves newly selected daily budget
    await budgetProvider.setBudget(
      date,
      selectedBudget,
    );
  }

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

  // calculated the total estimated duration of all todos scheduled for the selected day
  int _getPlannedDuration(BuildContext context) {
    final date = selectedDate;

    // no dates means no planned tasks to calculate
    if (date == null) {
      return 0;
    }

    final todoProvider = context.watch<TodoProvider>();

    // include open and completed todos in the calculation
    final todos = [
      ...todoProvider.openTodos,
      ...todoProvider.completedTodos,
    ];

    // only use todos that are scheduled for the selected day
    return todos.where((todo) {
      final scheduledDate = todo.scheduledDate;

      // ignore todos without a scheduled date
      if (scheduledDate == null) {
        return false;
      }

      // checks if todo is scheduled for the selected day
      return scheduledDate.year == date.year &&
          scheduledDate.month == date.month &&
          scheduledDate.day == date.day;
    }).fold(
      0,
      // adds estimated duration of each todo to the total
      (total, todo) => total + (todo.estimatedDuration ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // watches provider so that UI updates when the daily budget changes
    final budgetProvider = context.watch<DailyBudgetProvider>();

    final date = selectedDate;

    // if no day has been selected yet it shows only the default text
    if (date == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            QuestionnaireConstants.bufferTitle,
            style: TextStyle(
              fontSize: QuestionnaireConstants.sectionTitleFontSize,
              fontWeight: QuestionnaireConstants.titleFontWeight,
            ),
          ),
          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
                QuestionnaireConstants.bufferContainerPadding),
            decoration: BoxDecoration(
              color: AppThemeConstants.surfaceColor,
              borderRadius: BorderRadius.circular(
                  QuestionnaireConstants.bufferProcessBarRadius),
            ),
            child: const Text(
              QuestionnaireConstants.bufferSelectionText,
              style: TextStyle(
                color: AppThemeConstants.hintTextColor,
              ),
            ),
          ),
        ],
      );
    }

    // gets the budget values for the selected day
    final dailyBudget = budgetProvider.getBudget(date);
    final taskBudget = budgetProvider.getTaskBudget(date);
    final bufferTime = budgetProvider.getBufferTime(date);

    // calculates the total planned duration
    final plannedDuration =
        _getPlannedDuration(context) + (selectedDuration ?? 0);

    // calculates how much time is still available within the task budget
    final taskRemaining = (taskBudget - plannedDuration).clamp(0, taskBudget);

    // green part of process bar calcualtes how much of the daily budget is reserved for the task budget
    final taskProgress = dailyBudget != null && dailyBudget > 0
        ? (taskBudget / dailyBudget).clamp(0.0, 1.0)
        : 0.0;

    // time that goes beyond the task budget
    final overload = (plannedDuration - taskBudget).clamp(0, bufferTime);

    // how much of the buffer has already been used
    final bufferUsed = (plannedDuration - taskBudget).clamp(0, bufferTime);

    // how much buffer time is still available
    final bufferRemaining = bufferTime - bufferUsed;

    // true when planned task duration is above the normal task budget
    final taskTimeExceeded = plannedDuration > taskBudget;

    // true when planned duration exceeds both the task budget and available buffer
    final bufferExceeded = plannedDuration > taskBudget + bufferTime;

    // how many minutes the daily budget is exceeded
    final bufferExceededMinutes = plannedDuration - (taskBudget + bufferTime);

    // orange part of progress bar representing the used buffer time
    final overloadProgress =
        dailyBudget != null && dailyBudget > 0 ? overload / dailyBudget : 0.0;

    // calculates the total planned duration as a percentage of the daily budget
    final plannedProgress = dailyBudget != null && dailyBudget > 0
        ? (plannedDuration / dailyBudget).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          QuestionnaireConstants.bufferTitle,
          style: TextStyle(
            fontSize: QuestionnaireConstants.sectionTitleFontSize,
            fontWeight: QuestionnaireConstants.sectionTitleFontWeight,
          ),
        ),
        const SizedBox(
          height: AppThemeConstants.spacingSmall,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(
              QuestionnaireConstants.bufferContainerPadding),
          decoration: BoxDecoration(
            color: AppThemeConstants.surfaceColor,
            borderRadius: BorderRadius.circular(
                QuestionnaireConstants.bufferProcessBarRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if no daily budget is selected default text is shown
              // when clicked durationPicker opens
              if (dailyBudget == null)
                InkWell(
                  onTap: () => _pickDailyBudget(context),
                  child: const Text(
                    QuestionnaireConstants.bufferSelectionText,
                    style: TextStyle(
                      color: AppThemeConstants.hintTextColor,
                    ),
                  ),
                )
              else ...[
                // if a budget is selected the duration button displays the currently selected daily budget

                SizedBox(
                  width: double.infinity,
                  child: TodoDurationButton(
                    duration: dailyBudget,
                    onPressed: () => _pickDailyBudget(context),
                  ),
                ),

                const SizedBox(
                  height: AppThemeConstants.spacingSmall,
                ),

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

                            // shows the planned task time within the normal task budget
                            FractionallySizedBox(
                              widthFactor:
                                  plannedProgress.clamp(0.0, taskProgress),
                              child: Container(
                                color: QuestionnaireConstants.taskProgressColor,
                              ),
                            ),

                            // tasks that exceed the normal task budget and uses the available buffer time
                            if (overloadProgress > 0)
                              Positioned(
                                left: constraints.maxWidth * taskProgress,
                                child: Container(
                                  width:
                                      constraints.maxWidth * overloadProgress,
                                  height: QuestionnaireConstants
                                      .bufferProcessBarHeight,
                                  color: QuestionnaireConstants
                                      .bufferProgressColor,
                                ),
                              ),

                            // border seperating the task budget from the available buffer time
                            FractionallySizedBox(
                              widthFactor: taskProgress,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: QuestionnaireConstants
                                      .dateButtonBorderWidth,
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
                  height: 8,
                ),

                // displays the planned task time, remaining task time and remianing buffertime below the bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_formatDuration(plannedDuration)} / '
                      '${_formatDuration(taskBudget)} '
                      '${QuestionnaireConstants.taskLabel}',
                      style: const TextStyle(
                        fontSize:
                            QuestionnaireConstants.bufferwarningTextFontSize,
                      ),
                    ),
                    Text(
                      '${_formatDuration(taskRemaining)} '
                      '${QuestionnaireConstants.timeLeftLabel}',
                      style: const TextStyle(
                        fontSize:
                            QuestionnaireConstants.bufferwarningTextFontSize,
                      ),
                    ),
                    Text(
                      '${_formatDuration(bufferRemaining)} '
                      '${QuestionnaireConstants.bufferLeftLabel}',
                      style: const TextStyle(
                        fontSize:
                            QuestionnaireConstants.bufferwarningTextFontSize,
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
            ],
          ),
        ),
      ],
    );
  }
}
