import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class AppTheme {
  // background
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppThemeConstants.backgroundColor,

    // appbar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppThemeConstants.backgroundColor,
      foregroundColor: AppThemeConstants.hintTextColor,
    ),

    // text
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppThemeConstants.textColor,
        ),
        bodyMedium: TextStyle(
          color: AppThemeConstants.textColor,
        ),
        bodySmall: TextStyle(
          color: AppThemeConstants.textColor,
        ),
        titleLarge: TextStyle(
          color: AppThemeConstants.textColor,
        ),
        titleMedium: TextStyle(
          color: AppThemeConstants.textColor,
        ),
        titleSmall: TextStyle(
          color: AppThemeConstants.textColor,
        )),

    // inputfield
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppThemeConstants.hintTextColor,
      ),
    ),

    // text selection / cursor
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppThemeConstants.textColor,
      selectionHandleColor: AppThemeConstants.hintTextColor,
    ),

    // textbutton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppThemeConstants.textColor,
      ),
    ),

    // icons
    iconTheme: const IconThemeData(
      color: AppThemeConstants.textColor,
    ),

    // checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppThemeConstants.accentColor;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(
        AppThemeConstants.textColor,
      ),
      side: const BorderSide(
        color: AppThemeConstants.borderColor,
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),

    // elevatied buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeConstants.buttonColor,
        foregroundColor: AppThemeConstants.textColor,
      ),
    ),

    // bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppThemeConstants.appBarColor,
      selectedItemColor: AppThemeConstants.accentColor,
      unselectedItemColor: AppThemeConstants.textColor,
    ),
  );
}
