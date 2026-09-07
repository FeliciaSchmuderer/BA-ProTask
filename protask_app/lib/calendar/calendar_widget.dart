import 'package:flutter/material.dart';
import 'package:protask_app/constants/calendar_constants.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDaySelected;
  final List<TodoItem> todos;

  const CalendarWidget(
      {required this.selectedDate,
      required this.onDaySelected,
      required this.todos,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2200, 12, 31),

      // shows selected day or today´s date
      focusedDay: selectedDate ?? DateTime.now(),

      // visually marks selected day
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },

      // monday is the first day of the week !
      startingDayOfWeek: StartingDayOfWeek.monday,

      // shows a marker on days with todos
      eventLoader: (day) {
        return todos.where((todo) {
          if (todo.scheduledDate == null) {
            return false;
          }

          return isSameDay(todo.scheduledDate, day);
        }).toList();
      },

      // called when a day is selected
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);
      },
      // ),
    );
  }
}
