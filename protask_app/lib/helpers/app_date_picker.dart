import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class Appdatepicker {
  static final DateTime firstDate = DateTime(2020);
  static final DateTime lastDate = DateTime(2200);

  // opens date picker with the current selection as initial date
  static Future<DateTime?> selectDate(
    BuildContext context,
    DateTime? selectedDate,
  ) {
    return showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate,
        // dark theme
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                surface: Color(0xff1e1e1e),
                primary: AppThemeConstants.accentColor,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              dialogTheme: const DialogThemeData(
                backgroundColor: Color(0xff1e1e1e),
              ),
            ),
            child: child!,
          );
        });
  }
}
