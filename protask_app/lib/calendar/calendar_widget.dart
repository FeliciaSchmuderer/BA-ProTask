import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDaySelected;

  const CalendarWidget(
      {required this.selectedDate, required this.onDaySelected, super.key});

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

      // called when a day is selected
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);
      },
    );
  }
}
