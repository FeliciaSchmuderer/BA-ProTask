import 'package:flutter/material.dart';

class QuestionnaireConstants {
  // titles
  static const String todoHintText = 'Todo';
  static const String priorityTitle = 'Priority';
  static const String whenTitle = 'When?';
  static const String deadlineTitle = 'Deadline';
  static const String durationTitle = 'Duration';
  static const String bufferTitle = 'Buffer';

  static const String createTodoText = 'Create';
  static const String saveTodoText = 'Save';

  // general
  static const double buttonBorderRadius = 8;

  // (tags)
  static const double tagHorizonal = 4;
  static const double tagVertical = 2;
  static const double tagBorderRadius = 6;
  static const double tagFontSize = 12;

  // spacing
  static const double screenPadding = 24;
  static const double titleContentspacing = 20;
  static const double sectionSpacing = 40;
  static const double spacingSmall = 2;

  // fontweight
  static const FontWeight titleFontWeight = FontWeight.w900;
  static const FontWeight textFontWeight = FontWeight.normal;

  // buttons (general)
  static const double qButtonFontSize = 14;

  // todo input
  static const double todoTopSpacing = 32;
  static const double todoFontSize = 23;
  static const double todoHintFontSize = 18;
  static const FontWeight todoFontWeight = FontWeight.normal;

  // section titles
  static const double sectionTitleFontSize = 20;
  static const FontWeight sectionTitleFontWeight = FontWeight.w600;

  // priority
  static const double priorityFontSize = 18;

  static const double priorityButtonWidth = 50;
  static const double priorityButtonHeight = 50;

  static const double priorityButtonBorderRadius = 10;
  static const double priorityButtonBorderWidth = 1;
  static const double prioritySelectedButtonBorderWidth = 3;

  static const double prioritySpacing = 12;
  static const double removePriorityFontSize = 14;
  static const String removePriorityTitle = 'Remove Priority';

  // colors (priority)
  static const Color priorityAColor = Color(0xffFF453A);
  static const Color priorityBColor = Color(0xffFF9F0A);
  static const Color priorityCColor = Color(0xffFFD60A);
  static const Color priorityDColor = Color(0xff5E8CFF);

  // scheduled date buttons
  static const double dateButtonWidth = 100;
  static const double dateButtonHeight = 60;
  static const double dateButtonBorderRadius = 13;
  static const double dateButtonBorderWidth = 1.5;

  // static const double dateFontSize = 10;
  static const double dateTextSpacing = 4;

  static const String dateTextToday = 'Today';
  static const String dateTextTomorrow = 'Tomorrow';
  static const String dateTextPick = 'Pick Date';

  // deadline buttons
  static const String deadlineTextPick = 'Pick Deadline';
  static const String deadlineTimeTextPick = 'Pick Time';
  static const String removeDeadlineText = 'Remove Deadline';

  static const double deadlineButtonWidth = 140;
  static const double deadlineButtonHeight = 50;

  static const double deadlineButtonBorderRadius = 10;
  static const double deadlineButtonBorderWidth = 1;

  // duration
  static const String durationTextPick = 'Pick Duration';
  static const String removeDurationText = 'Remove Duration';

  // buffer section
  static const double bufferContainerPadding = 16.0;
  static const double bufferProcessBarHeight = 12.0;
  static const double bufferProcessBarRadius = 6.0;

  static const Color taskProgressColor = Color(0xff62A30D);
  static const Color bufferProgressColor = Color(0xffFF9F0A);
  static const Color bufferExceededColor = Color(0xffFF453A);

  static const double bufferwarningTextFontSize = 10;

  static const String bufferSelectionText =
      'Select your time budget for this day';
  static const String bufferSelectionTextShort = 'Set daily budget';
  static const String taskLabel = 'tasks';
  static const String timeLeftLabel = 'left';
  static const String bufferLeftLabel = 'buffer left';
  static const String orangeWarningText = 'Your buffer is exceeded by ';
  static const String orangeWarningSuffix =
      'You should really consider to move tasks to another day!';
  static const String redWarningText =
      'Your task time is exceeded. Buffer time is being used. Consider moving tasks to another day.';

  // create button
  static const double createButtonHorizonal = 50;
  static const double createButtonVertical = 20;
  static const double createButtonRadius = 45;
  static const double createButtonFontSize = 18;
}
