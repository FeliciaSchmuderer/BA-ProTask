// manages saving, loading, changing and selected day for daily budget (puffer)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyBudgetProvider extends ChangeNotifier {
  final Map<String, int> _dailyBudgets = {};

  DailyBudgetProvider() {
    _loadBudgets();
  }

  Map<String, int> get dailyBudgets => Map.unmodifiable(_dailyBudgets);

  int? getBudget(DateTime date) {
    return _dailyBudgets[_dateKey(date)];
  }

  int getTaskBudget(DateTime date) {
    final budget = getBudget(date);

    if (budget == null) {
      return 0;
    }

    return (budget * 0.6).round();
  }

  int getBufferTime(DateTime date) {
    final budget = getBudget(date);

    if (budget == null) {
      return 0;
    }

    return (budget * 0.4).round();
  }

  Future<void> setBudget(
    DateTime date,
    int minutes,
  ) async {
    _dailyBudgets[_dateKey(date)] = minutes;

    await _saveBudgets();
    notifyListeners();
  }

  Future<void> removeBudget(DateTime date) async {
    _dailyBudgets.remove(_dateKey(date));

    await _saveBudgets();
    notifyListeners();
  }

  String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<void> _loadBudgets() async {
    final prefs = await SharedPreferences.getInstance();

    final savedBudgets = prefs.getStringList('dailyBudgets') ?? [];

    for (final entry in savedBudgets) {
      final parts = entry.split('|');

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

  Future<void> _saveBudgets() async {
    final prefs = await SharedPreferences.getInstance();

    final savedBudgets = _dailyBudgets.entries.map((entry) {
      return '${entry.key}|${entry.value}';
    }).toList();

    await prefs.setStringList(
      'dailyBudgets',
      savedBudgets,
    );
  }
}
