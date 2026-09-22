import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/widgets/budget_progress_view.dart';
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

  // calculated the current task time for all todos
  int _getTaskDuration(BuildContext context) {
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
      // completed todo with actual timer result
      (total, todo) {
        if (todo.isChecked && todo.actualDuration > 0) {
          return total + todo.actualDuration;
        }

        // opens todo or completed todo without actual timer result
        return total + (todo.estimatedDuration ?? 0);
      },
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
              QuestionnaireConstants.bufferContainerPadding,
            ),
            decoration: BoxDecoration(
              color: AppThemeConstants.surfaceColor,
              borderRadius: BorderRadius.circular(
                QuestionnaireConstants.bufferProcessBarRadius,
              ),
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

    // calculates task duration using estimated or actual duration per todo
    final taskDuration = _getTaskDuration(context) + (selectedDuration ?? 0);

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
            QuestionnaireConstants.bufferContainerPadding,
          ),
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
                // shared progress bar and budget information
                BudgetProgressView(
                  dailyBudget: dailyBudget,
                  taskBudget: taskBudget,
                  bufferTime: bufferTime,
                  taskDuration: taskDuration,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
