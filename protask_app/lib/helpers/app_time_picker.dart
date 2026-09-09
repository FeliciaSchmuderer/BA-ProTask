import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTimePicker {
  // opens wheel time picker with the current selection as initial time
  static Future<TimeOfDay?> selectTime(
    BuildContext context,
    TimeOfDay? selectedTime,
  ) async {
    final initialTime = selectedTime ?? TimeOfDay.now();

    TimeOfDay? pickedTime;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              initialDateTime: DateTime.now().copyWith(
                hour: initialTime.hour,
                minute: initialTime.minute,
              ),
              onDateTimeChanged: (DateTime newTime) {
                pickedTime = TimeOfDay(
                  hour: newTime.hour,
                  minute: newTime.minute,
                );
              },
            ),
          ),
        );
      },
    );
    return pickedTime;
  }
}
