import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class AppTimePicker {
  // opens wheel time picker with the current selection as initial time
  static Future<TimeOfDay?> selectTime(
    BuildContext context,
    TimeOfDay? selectedTime,
  ) async {
    // uses selected time or the current time if no time is selected
    final initialTime = selectedTime ?? TimeOfDay.now();

    // stores time selected by user
    TimeOfDay? pickedTime;

    // shows time picker as a Cuperino modal popup
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          color: AppThemeConstants.backgroundColor,
          child: SafeArea(
            top: false,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: AppThemeConstants.textColor,
                    fontSize: 22,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: DateTime.now().copyWith(
                  hour: initialTime.hour,
                  minute: initialTime.minute,
                ),
                onDateTimeChanged: (DateTime newTime) {
                  // convert selected DateTime into a TimeOfDay
                  pickedTime = TimeOfDay(
                    hour: newTime.hour,
                    minute: newTime.minute,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    return pickedTime;
  }
}
