import 'package:flutter/material.dart';

class Appdatepicker {
  static final DateTime firstDate = DateTime(2020);
  static final DateTime lastDate = DateTime(2200);

  static Future<DateTime?> selectDate(
    BuildContext context,
    DateTime? selectedDate,
  ) {
    return showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}

