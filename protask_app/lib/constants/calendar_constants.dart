import 'package:table_calendar/table_calendar.dart';

class CalendarConstants {
  // texts
  static const String title = "Calendar";
  static const String noTodoText = "No Todos for this day";

  // spacing
  static const double spaceAfterSelectedDate = 50;
  static const double spaceAfterTodos = 70;

  // calendar range
  static final DateTime firstDay = DateTime.utc(2000, 1, 1);
  static final DateTime lastDay = DateTime.utc(2200, 12, 31);

  // week
  static const StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.monday;
}
