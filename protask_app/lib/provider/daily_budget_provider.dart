// manages saving, loading, changing and selected day for daily budget (buffer)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyBudgetProvider extends ChangeNotifier {
  // stores daily budgets using the date as the key
  final Map<String, int> _dailyBudgets = {};

  // loading saved budgets
  DailyBudgetProvider() {
    _loadBudgets();
  }

  // returns saved budget for a specific day
  // returns null when no budget is selected
  int? getBudget(DateTime date) {
    return _dailyBudgets[_dateKey(date)];
  }

  // calculates remaining task budget -> 60% of daily budget is reserved for normal tasks
  int getTaskBudget(DateTime date) {
    final budget = getBudget(date);

    if (budget == null) {
      return 0;
    }
    return (budget * 0.6).round();
  }

  // calculates available buffer time -> 40% of daily budget is reserved as buffer
  int getBufferTime(DateTime date) {
    final budget = getBudget(date);

    if (budget == null) {
      return 0;
    }

    return (budget * 0.4).round();
  }

  // saves or updates daily budget for a selected day
  Future<void> setBudget(
    DateTime date,
    int minutes,
  ) async {
    _dailyBudgets[_dateKey(date)] = minutes;

    // saves updated budgets locally
    await _saveBudgets();

    notifyListeners();
  }

  // removes the daily budget for a selected day
  Future<void> removeBudget(DateTime date) async {
    _dailyBudgets.remove(_dateKey(date));

    await _saveBudgets();

    notifyListeners();
  }

  // creates a unique string key for each date
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  // loads all previously saved daily budgets from SharedPreferences
  Future<void> _loadBudgets() async {
    final prefs = await SharedPreferences.getInstance();

    // gets the saved budget entries
    final savedBudgets = prefs.getStringList('dailyBudgets') ?? [];

    // converts every saved entry back into a date and duration
    for (final entry in savedBudgets) {
      final parts = entry.split('|');

      // ignore invalid entries
      if (parts.length != 2) {
        continue;
      }

      final date = parts[0];
      final minutes = int.tryParse(parts[1]);

      if (minutes != null) {
        _dailyBudgets[date] = minutes;
      }
    }
    notifyListeners();
  }

  // saves all current daily budgets to SharedPreferences
  Future<void> _saveBudgets() async {
    final prefs = await SharedPreferences.getInstance();

    // converts map into a list of strings so it can be stored with SharedPreferences
    final savedBudgets = _dailyBudgets.entries.map((entry) {
      return '${entry.key}|${entry.value}';
    }).toList();

    // saves complete list locally
    await prefs.setStringList(
      'dailyBudgets',
      savedBudgets,
    );
  }
}
