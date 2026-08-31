import 'package:flutter/material.dart';
import 'package:protask_app/calendar/calendar_widget.dart';

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
    return Padding(
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
          )
        ],
      ),
    );
  }
}
