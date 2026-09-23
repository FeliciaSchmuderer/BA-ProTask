import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/eisenhower_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/eisenhower_matrix/eisenhower_quadrants.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';
import 'package:provider/provider.dart';

class EisenhowerScreen extends StatefulWidget {
  const EisenhowerScreen({super.key});

  @override
  State<EisenhowerScreen> createState() => _EisenhowerScreenState();
}

class _EisenhowerScreenState extends State<EisenhowerScreen> {
  // stores the currently selcted date for the matrix
  DateTime _selectedDate = DateTime.now();

  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(
        const Duration(days: 1),
      );
    });
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(
        const Duration(days: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();

    // only open todos are in the matrix
    final todos = todoProvider.openTodos;

    // todos without a date automatically get today
    final selectedDateTodos = todos.where((todo) {
      if (todo.scheduledDate == null) {
        return _selectedDate.year == DateTime.now().year &&
            _selectedDate.month == DateTime.now().month &&
            _selectedDate.day == DateTime.now().day;
      }
      // todos with a scheduled date are shown on their scheduled date
      return todo.scheduledDate!.year == _selectedDate.year &&
          todo.scheduledDate!.month == _selectedDate.month &&
          todo.scheduledDate!.day == _selectedDate.day;
    }).toList();

    // sorting todos by their priority
    final priorityATodos = selectedDateTodos
        .where((todo) => todo.priority == TodoPriority.a)
        .toList();

    final priorityBTodos = selectedDateTodos
        .where((todo) => todo.priority == TodoPriority.b)
        .toList();

    final priorityCTodos = selectedDateTodos
        .where((todo) => todo.priority == TodoPriority.c)
        .toList();

    final priorityDTodos = selectedDateTodos
        .where((todo) => todo.priority == TodoPriority.d)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(EisenhowerConstants.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tile
          const Text(
            EisenhowerConstants.screenTitle,
            style: TextStyle(
              fontSize: AppThemeConstants.titleFontSize,
              fontWeight: AppThemeConstants.titleFontWeight,
            ),
          ),

          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),

          // option to switch between dates
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _previousDay,
                icon: const Icon(AppThemeConstants.leftChevronIcon),
              ),
              Text(
                '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                style: const TextStyle(
                  fontSize: AppThemeConstants.bodyFontSize,
                  fontWeight: AppThemeConstants.subtitleFontWeight,
                ),
              ),
              IconButton(
                onPressed: _nextDay,
                icon: const Icon(AppThemeConstants.rightChevronIcon),
              ),
            ],
          ),

          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),

          // the four Eisenhower quadrants
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              // two quadrants next to each other
              const columnCount = EisenhowerConstants.columnCount;

              // calculates the width of each quadrant
              final itemWidth = (width - 12) / columnCount;

              return Wrap(
                spacing: EisenhowerConstants.quadrantSpacing,
                runSpacing: EisenhowerConstants.quadrantSpacing,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: EisenhowerQuadrants(
                      title: EisenhowerConstants.quadrantA,
                      todos: priorityATodos,
                      priorityColor: QuestionnaireConstants.priorityAColor,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: EisenhowerQuadrants(
                      title: EisenhowerConstants.quadrantB,
                      todos: priorityBTodos,
                      priorityColor: QuestionnaireConstants.priorityBColor,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: EisenhowerQuadrants(
                      title: EisenhowerConstants.quadrantC,
                      todos: priorityCTodos,
                      priorityColor: QuestionnaireConstants.priorityCColor,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: EisenhowerQuadrants(
                      title: EisenhowerConstants.quadrantD,
                      todos: priorityDTodos,
                      priorityColor: QuestionnaireConstants.priorityDColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
