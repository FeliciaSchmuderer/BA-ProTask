import 'dart:async';

import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';

// current state of todotimer
enum TodoTimerState {
  idle,
  running,
  paused,
  stopped,
  expired,
  finished,
}

// manages timer for a todo
class TimerProvider extends ChangeNotifier {
  // todo for which the curernt timer is running
  TodoItem? _activeTodo;

  // time when timer is started
  DateTime? _startedAt;

  // timer which updates UI every second
  Timer? _ticker;

  // current state of the timer
  TodoTimerState _state = TodoTimerState.idle;

  // returns the current active todo
  TodoItem? get activeTodo => _activeTodo;

  // returns the current timer state
  TodoTimerState get state => _state;

  // return if the timer is currently running
  bool get isRunning => _state == TodoTimerState.running && _startedAt != null;

  // starts the timer for a todo
  void startTimer(TodoItem todo) {
    if (_activeTodo != null && _activeTodo!.id != todo.id && isRunning) {
      return;
    }

    _activeTodo = todo;
    _startedAt = DateTime.now();
    _state = TodoTimerState.running;

    _startTicker();

    notifyListeners();
  }

  // pauses the timer
  void pauseTimer() {
    if (!isRunning) {
      return;
    }

    _state = TodoTimerState.paused;

    _stopTicker();

    notifyListeners();
  }

  // stops the timer
  void stopTimer() {
    _stopTicker();

    // resets start time
    _startedAt = null;
    _state = TodoTimerState.stopped;

    notifyListeners();
  }

  // finish -> ends the timer finally
  void finishTimer() {
    _stopTicker();

    _startedAt = null;
    _state = TodoTimerState.finished;

    notifyListeners();
  }

  // remaining time
  // calculateds the current left left time for a todo
  Duration getRemainingTime(TodoItem todo) {
    // once timer has expired always show zero
    if (_state == TodoTimerState.expired) {
      return Duration.zero;
    }

    final estimatedMinutes = todo.estimatedDuration ?? 0;
    final totalDuration = Duration(minutes: estimatedMinutes);

    // timer has not started yet
    if (_activeTodo?.id != todo.id || _startedAt == null) {
      return totalDuration;
    }

    // calculates how much time has passed since the start
    final elapsed = DateTime.now().difference(_startedAt!);

    final remaining = totalDuration - elapsed;

    // never returning negative duration if time has already passed
    if (remaining.isNegative) {
      return Duration.zero;
    }

    return remaining;
  }

  // ticker in sceonds
  void _startTicker() {
    // stopping an eventual old timer
    _stopTicker();

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_activeTodo == null) {
        return;
      }

      final remaining = getRemainingTime(_activeTodo!);

      if (remaining <= Duration.zero) {
        _stopTicker();

        _startedAt = null;
        _state = TodoTimerState.expired;

        notifyListeners();
        return;
      }

      notifyListeners();
    });
  }

  // stops the seconds ticker
  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  // is called when provider is not needed anymore
  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }
}
