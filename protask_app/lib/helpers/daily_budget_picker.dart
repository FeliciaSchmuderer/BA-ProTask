import 'package:flutter/material.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';

Future<void> pickDailyBudget(
  BuildContext context,
  DailyBudgetProvider budgetProvider,
  DateTime date,
) async {
  final currentBudget = budgetProvider.getBudget(date);

  final selectedBudget = await AppDurationPicker.selectDuration(
    context,
    currentBudget,
  );

  // user cancelling picker
  if (selectedBudget == null) {
    return;
  }

  // 0 removes budget
  if (selectedBudget == 0) {
    await budgetProvider.removeBudget(date);
    return;
  }

  // saves selected budget
  await budgetProvider.setBudget(
    date,
    selectedBudget,
  );
}
