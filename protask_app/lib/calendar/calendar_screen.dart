import 'package:flutter/material.dart';
import 'package:protask_app/calendar/calendar_widget.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/constants/calendar_constants.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// displays calendar and todos for selected day
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // currently selected day
  DateTime? _selectedDate;

  // updates selected day when user selects a date
  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    // gets all todos from central provider
    final todoProvider = context.watch<TodoProvider>();

    // combines open and completed todos for calendar
    final List<TodoItem> todos = [
      ...todoProvider.openTodos,
      ...todoProvider.completedTodos,
    ];

    // filters todos based on the selected date
    final filteredTodos = todos.where((todo) {
      if (todo.scheduledDate == null || _selectedDate == null) {
        return false;
      }

      return isSameDay(todo.scheduledDate, _selectedDate);
    }).toList();

    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            CalendarConstants.title,
            style: TextStyle(
              fontSize: AppConstants.titleFontSize,
              fontWeight: AppConstants.titleFontWeight,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          CalendarWidget(
            selectedDate: _selectedDate,
            onDaySelected: _onDaySelected,
            todos: todos,
          ),
          if (_selectedDate != null)
            Text(
              "Todos on ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}",
              style: const TextStyle(
                fontSize: AppConstants.subtitleFontSize,
                fontWeight: AppConstants.titleFontWeight,
              ),
            ),

          if (_selectedDate != null && filteredTodos.isEmpty) ...[
            const SizedBox(height: CalendarConstants.spaceAfterSelectedDate),
            const Center(
              child: Text(
                CalendarConstants.noTodoText,
                style: TextStyle(fontSize: AppConstants.bodyFontSize),
              ),
            ),
          ],

          // displays scheduled todos for the selected day
          ...filteredTodos.map(
            (todo) => TodoTile(
              todo: todo,
              onChanged: (value) {
                context.read<TodoProvider>().toggleTodo(todo, value!);
              },
              onDelete: () {
                context.read<TodoProvider>().deleteTodo(todo);
              },
            ),
          ),

          const SizedBox(
            height: CalendarConstants.spaceAfterTodos,
          )
        ],
      ),
    );
  }
}
