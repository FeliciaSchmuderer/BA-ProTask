import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/budget_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/widgets/budget_progress_view.dart';
import 'package:protask_app/widgets/todo_duration_button.dart';
import 'package:provider/provider.dart';

class BudgetDetailsDialog extends StatelessWidget {
  final int taskDuration;
  final DateTime selectedDate;

  const BudgetDetailsDialog({
    super.key,
    required this.taskDuration,
    required this.selectedDate,
  });

  // changes or sets new daily budget
  Future<void> _changeBudget(BuildContext context) async {
    final budgetProvider = context.read<DailyBudgetProvider>();

    // always get the current budget from the provider
    final currenBudget = budgetProvider.getBudget(selectedDate);

    final selectedBudget = await AppDurationPicker.selectDuration(
      context,
      currenBudget,
    );

    if (selectedBudget == null) {
      return;
    }

    if (selectedBudget == 0) {
      await budgetProvider.removeBudget(selectedDate);

      if (context.mounted) {
        Navigator.of(context).pop();
      }
      return;
    }

    await budgetProvider.setBudget(
      selectedDate,
      selectedBudget,
    );
  }

  @override
  Widget build(BuildContext context) {
    // dialog rebuilds whenever the budget changes
    final budgetProvider = context.watch<DailyBudgetProvider>();

    // always use the current values from the provider
    final dailyBudget = budgetProvider.getBudget(selectedDate);
    final taskBudget = budgetProvider.getTaskBudget(selectedDate);
    final bufferTime = budgetProvider.getBufferTime(selectedDate);

    return Dialog(
      backgroundColor: AppThemeConstants.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          BudgetConstants.dialogRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          BudgetConstants.budgetDialogPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              BudgetConstants.budgetText,
              style: TextStyle(
                fontSize: BudgetConstants.budgetFontSize,
                fontWeight: BudgetConstants.budgetTextFontWeight,
              ),
            ),
            const SizedBox(
              height: AppThemeConstants.spacingMedium,
            ),

            // shows an option to set the budget if none is set up
            if (dailyBudget == null)
              InkWell(
                onTap: () => _changeBudget(context),
                child: const Text(
                  BudgetConstants.setBudgetText,
                  style: TextStyle(
                    color: AppThemeConstants.hintTextColor,
                  ),
                ),
              )

            // budget exists
            else ...[
              SizedBox(
                width: double.infinity,
                child: TodoDurationButton(
                  duration: dailyBudget,
                  onPressed: () => _changeBudget(context),
                ),
              ),

              const SizedBox(
                height: AppThemeConstants.spacingSmall,
              ),

              // displays progress of the task budget and buffer
              BudgetProgressView(
                dailyBudget: dailyBudget,
                taskBudget: taskBudget,
                bufferTime: bufferTime,
                taskDuration: taskDuration,
              ),

              const SizedBox(
                height: AppThemeConstants.spacingMedium,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(BudgetConstants.closeBudgetText),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
