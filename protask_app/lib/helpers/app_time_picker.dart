import 'package:flutter/material.dart';

class AppTimePicker {
  // opens time picker with the current selection as initial time
  static Future<TimeOfDay?> selectTime(
    BuildContext context,
    TimeOfDay? selectedTime,
  ) {
    return showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }
}
