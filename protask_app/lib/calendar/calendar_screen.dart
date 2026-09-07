import 'package:flutter/material.dart';
import 'package:protask_app/calendar/calendar_widget.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// mainly calendar ui i guess ?
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // currently selected day
  DateTime? _selectedDate;

  // METHOD?

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();

    final List<TodoItem> todos = [
      ...todoProvider.openTodos,
      ...todoProvider.completedTodos,
    ];

    // filters todos based on the selected date
    final filteredTodos = todos.where((todo) {
      if (todo.dueDate == null || _selectedDate == null) {
        return false;
      }

      return isSameDay(todo.dueDate, _selectedDate);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Calendar",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CalendarWidget(
            selectedDate: _selectedDate,
            onDaySelected: _onDaySelected,
            todos: todos,
          ),
          
          
          if (_selectedDate != null)
            Text(
              "Todos für ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 10,
          ),
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
        ],
      ),
    );
  }
}
