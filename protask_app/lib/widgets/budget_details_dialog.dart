import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/budget_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/widgets/budget_progress_view.dart';
import 'package:protask_app/widgets/todo_duration_button.dart';
import 'package:provider/provider.dart';

class BudgetDetailsDialog extends StatelessWidget {
  final int? dailyBudget;
  final int taskBudget;
  final int bufferTime;
  final int taskDuration;

  const BudgetDetailsDialog({
    super.key,
    required this.dailyBudget,
    required this.taskBudget,
    required this.bufferTime,
    required this.taskDuration,
  });

  // changes or sets new daily budget
  Future<void> _changeProvider(BuildContext context) async {
    final budgetProvider = context.read<DailyBudgetProvider>();
    final today = DateTime.now();

    final selectedBudget = await AppDurationPicker.selectDuration(
      context,
      dailyBudget,
    );

    if (selectedBudget == null) {
      return;
    }

    if (selectedBudget == 0) {
      await budgetProvider.removeBudget(today);
    } else {
      await budgetProvider.setBudget(
        today,
        selectedBudget,
      );
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => _changeProvider(context),
                child: const Text(
                  BudgetConstants.setBudgetText,
                  style: TextStyle(
                    color: AppThemeConstants.hintTextColor,
                  ),
                ),
              )
            else ...[
              SizedBox(
                width: double.infinity,
                child: TodoDurationButton(
                  duration: dailyBudget!,
                  onPressed: () => _changeProvider(context),
                ),
              ),

              const SizedBox(
                height: AppThemeConstants.spacingSmall,
              ),

              // displays progress of the task budget and buffer
              BudgetProgressView(
                dailyBudget: dailyBudget!,
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
