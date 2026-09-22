import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/todo_screen_constants.dart';
import 'package:protask_app/provider/daily_budget_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_list.dart';
import 'package:protask_app/todo_questionnaire/todo_questionnaire_route.dart';
import 'package:protask_app/widgets/budget_details_dialog.dart';

import 'package:protask_app/widgets/app_input_field.dart';
import 'package:protask_app/widgets/todo_budget_tag.dart';
import 'package:provider/provider.dart';
import 'package:protask_app/provider/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // makes textfield active
  final TextEditingController _controller = TextEditingController();

// cleans up controller when screen is removed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // checks if text exists and adds a new todo
  void addTodo() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    // adds todo to the central todo lists
    context.read<TodoProvider>().addTodo(
          _controller.text,
          scheduledDate: DateTime.now(),
        );

    // clears textfield after adding a todo
    _controller.clear();
  }

  // checks if a todo is scheduled for today
  bool _isToday(DateTime? date) {
    if (date == null) {
      return true;
    }

    final today = DateTime.now();

    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  // opens budget details popup when clicked on the budget tag
  void _showBudgetDetails(
    BuildContext context,
    DailyBudgetProvider budgetProvider,
    TodoProvider todoProvider,
  ) {
    final today = DateTime.now();

    final dailyBudget = budgetProvider.getBudget(today);
    final taskBudget = budgetProvider.getTaskBudget(today);
    final bufferTime = budgetProvider.getBufferTime(today);

    // calculates planned task duration for the day
    final taskDuration = [
      ...todoProvider.openTodos,
      ...todoProvider.completedTodos,
    ].where((todo) {
      return _isToday(todo.scheduledDate);
    }).fold<int>(
      0,
      (total, todo) {
        if (todo.isChecked && todo.actualDuration > 0) {
          return total + todo.actualDuration;
        }

        return total + (todo.estimatedDuration ?? 0);
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        return BudgetDetailsDialog(
          dailyBudget: dailyBudget,
          taskBudget: taskBudget,
          bufferTime: bufferTime,
          taskDuration: taskDuration,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TodoScreen rebuilds automatically whenever provider changes
    final todoProvider = context.watch<TodoProvider>();
    // only display todos scheduled for today
    final openTodos = todoProvider.openTodos
        .where((todo) => _isToday(todo.scheduledDate))
        .toList();
    final completedTodos = todoProvider.completedTodos;

    // budget tag
    final budgetProvier = context.watch<DailyBudgetProvider>();
    final dailyBudget = budgetProvier.getBudget(DateTime.now());
    final taskBudget = budgetProvier.getTaskBudget(DateTime.now());

    // calculates task duration using estimated or actual durations
    final taskDuration = [
      ...todoProvider.openTodos,
      ...todoProvider.completedTodos,
    ].where((todo) {
      return _isToday(todo.scheduledDate);
    }).fold<int>(0, (total, todo) {
      if (todo.isChecked && todo.actualDuration > 0) {
        return total + todo.actualDuration;
      }
      return total + (todo.estimatedDuration ?? 0);
    });

    final timeLeft = (taskBudget - taskDuration).clamp(0, taskBudget);

    return Scaffold(
      // title "Today" and date below
      body: Padding(
        padding: AppThemeConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // displays the current page title
            const Text(
              TodoScreenConstants.title,
              style: TextStyle(
                  color: AppThemeConstants.textColor,
                  fontSize: AppThemeConstants.titleFontSize,
                  fontWeight: AppThemeConstants.titleFontWeight),
            ),

            // space between title and date
            const SizedBox(
              height: AppThemeConstants.spacingMini,
            ),

            // displays current date
            Text(
              AppThemeConstants.currentDate,
              style: const TextStyle(
                  color: AppThemeConstants.textColor,
                  fontSize: AppThemeConstants.subtitleFontSize,
                  fontWeight: AppThemeConstants.subtitleFontWeight),
            ),

            // space before the todo list
            const SizedBox(
              height: AppThemeConstants.spacingMedium,
            ),

            // budget tag display
            TodoBudgetTag(
              budget: dailyBudget,
              timeLeft: timeLeft,
              onPressed: () => _showBudgetDetails(
                context,
                budgetProvier,
                todoProvider,
              ),
            ),
            const SizedBox(
              height: AppThemeConstants.spacingMedium,
            ),

            // displays todo list in the middle of the screen and handles checkbox changes
            // keeps todo list between the header and the input field
            Expanded(
              child: TodoList(
                openTodos: openTodos,
                completedTodos: completedTodos,
                onChanged: (value, todo) {
                  context.read<TodoProvider>().toggleTodo(todo, value!);
                },
                onDelete: (todo) {
                  context.read<TodoProvider>().deleteTodo(todo);
                },
                onReorder: (oldIndex, newIndex) {
                  context.read<TodoProvider>().reorderTodo(
                        oldIndex,
                        newIndex,
                      );
                },
              ),
            ),

            const SizedBox(
              height: AppThemeConstants.spacingSmall,
            ),

            // input field for creating new todos
            AppInputField(
              controller: _controller,
              hintText: TodoScreenConstants.hintText,
              onSubmitted: addTodo,
              onQuestionnairePressed: () {
                Navigator.push(
                  context,
                  TodoQuestionnaireRoute.create(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
