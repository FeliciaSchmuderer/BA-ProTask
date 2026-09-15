import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/widgets/todo_duration_button.dart';
import 'package:provider/provider.dart';

class BufferSection extends StatelessWidget {
  final DateTime selectedDate;

  const BufferSection({
    super.key,
    required this.selectedDate,
  });

  // open duration picker for daily budget selection
  Future<void> _pickDailyBudget(BuildContext context) async {
    final budgetProvider = context.read<DailyBudgetProvider>();

    final currentBudget = budgetProvider.getBudget(selectedDate);

    final selectedBudget = await AppDurationPicker.selectDuration(
      context,
      currentBudget,
    );

    if (selectedBudget == null || selectedBudget <= 0) {
      return;
    }

    await budgetProvider.setBudget(
      selectedDate,
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

  @override
  Widget build(BuildContext context) {
    final budgetProvider = context.watch<DailyBudgetProvider>();

    final dailyBudget = budgetProvider.getBudget(selectedDate);

    final taskBudget = budgetProvider.getTaskBudget(selectedDate);

    final bufferTime = budgetProvider.getBufferTime(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          QuestionnaireConstants.pufferTitle,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppThemeConstants.surfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoDurationButton(
                duration: dailyBudget,
                onPressed: () => _pickDailyBudget(context),
              ),
              if (dailyBudget != null) ...[
                const SizedBox(
                  height: AppThemeConstants.spacingSmall,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: const LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 12,
                    backgroundColor: AppThemeConstants.backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_formatDuration(taskBudget)} tasks',
                    ),
                    Text(
                      '${_formatDuration(bufferTime)} buffer',
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
