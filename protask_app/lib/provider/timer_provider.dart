import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // full duration of the current duration timer
  Duration? _timerDuration;

  // original duration of the task
  Duration? _originalTimerDuration;

  // remaining time when timer was paused
  Duration? _pausedRemainingTime;

  // total time actually worked during this session for later budget calculations
  Duration _workedDuration = Duration.zero;

  // checks if additional time has been selected but not started
  bool _hasAdditionalTimeSelected = false;

  // timer which updates UI every second
  Timer? _ticker;

  // current state of the timer
  TodoTimerState _state = TodoTimerState.idle;

  // returns the current active todo
  TodoItem? get activeTodo => _activeTodo;

  // returns the current timer state
  TodoTimerState get state => _state;

  // return the total actually worked duration
  Duration get workedDuration => _workedDuration;

  // return if the timer is currently running
  bool get isRunning => _state == TodoTimerState.running && _startedAt != null;

  // starts the timer for a todo
  void startTimer(TodoItem todo) {
    if (_activeTodo != null && _activeTodo!.id != todo.id && isRunning) {
      return;
    }

    _activeTodo = todo;

    // set original estimated duration only when starting a completely new task/timer
    _originalTimerDuration ??= Duration(
      minutes: todo.estimatedDuration ?? 0,
    );

    _timerDuration ??= _originalTimerDuration;

    _hasAdditionalTimeSelected = false;

    // continures from the remaining time when the timer was paused
    if (_state == TodoTimerState.paused && _pausedRemainingTime != null) {
      _timerDuration = _pausedRemainingTime;
      _pausedRemainingTime = null;
    }

    _startedAt = DateTime.now();
    _state = TodoTimerState.running;

    _startTicker();

    notifyListeners();
  }

  // adds additional time after the timer has expired
  void addAdditionalTime(int minutes) {
    if (_activeTodo == null || minutes <= 0) {
      return;
    }

    // additional time becomes new active timer duration
    _timerDuration = Duration(minutes: minutes);

    _hasAdditionalTimeSelected = true;

    // timer is ready, but not started yet
    _startedAt = null;
    _pausedRemainingTime = null;

    _state = TodoTimerState.expired;

    notifyListeners();
  }

  // starting the timer for the additional time
  void startAdditionalTime() {
    if (_activeTodo == null || _timerDuration == null) {
      return;
    }

    _hasAdditionalTimeSelected = false;

    _startedAt = DateTime.now();
    _pausedRemainingTime = null;

    _state = TodoTimerState.running;

    _startTicker();

    notifyListeners();
  }

  // pauses the timer
  void pauseTimer() {
    if (!isRunning || _startedAt == null) {
      return;
    }

    final now = DateTime.now();

    // calculates actually worked time
    final elapsed = now.difference(_startedAt!);

    // adds elapsed time to the total worked duration
    _workedDuration += elapsed;

    // calculates and saves the remaining time before pausing the ticker
    if (_activeTodo != null) {
      final remaining = getRemainingTime(_activeTodo!);

      _pausedRemainingTime = remaining;
    }

    // time is no longer running
    _startedAt = null;

    _state = TodoTimerState.paused;

    _stopTicker();

    notifyListeners();
  }

  // stops the timer
  void stopTimer() {
    _stopTicker();

    // reset paused time
    _pausedRemainingTime = null;

    // resets start time
    _startedAt = null;

    // resets actual worked time and no time from this session is saved
    _workedDuration = Duration.zero;

    // keeps the recently set up timer
    _state = TodoTimerState.stopped;

    notifyListeners();
  }

  // finish -> ends the timer finally
  void finishTimer() {
    // adds the worked time since the last start
    if (isRunning && _startedAt != null) {
      final now = DateTime.now();
      final elapsed = now.difference(_startedAt!);

      _workedDuration += elapsed;
    }
    _stopTicker();

    _startedAt = null;
    _pausedRemainingTime = null;

    _state = TodoTimerState.finished;

    notifyListeners();
  }

  // remaining time
  // calculateds the current left time for a todo
  Duration getRemainingTime(TodoItem todo) {
    final estimatedMinutes = todo.estimatedDuration ?? 0;

    final totalDuration = Duration(minutes: estimatedMinutes);

    // todo is not the active todo
    if (_activeTodo?.id != todo.id) {
      return totalDuration;
    }

    // once timer has expired always show zero
    if (_state == TodoTimerState.expired && !_hasAdditionalTimeSelected) {
      return Duration.zero;
    }

    // uses current timer duration, it can be either the original one or the additional
    final currentDuration = _timerDuration ?? totalDuration;

    // return the exact remaining time from the moment of pause
    if (_state == TodoTimerState.paused && _pausedRemainingTime != null) {
      return _pausedRemainingTime!;
    }

    // timer has not started yet
    if (_startedAt == null) {
      return currentDuration;
    }

    // calculates how much time has passed since the start
    final elapsed = DateTime.now().difference(_startedAt!);

    // calculate remaining time from the current timer
    final remaining = currentDuration - elapsed;

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

    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_activeTodo == null || _startedAt == null) {
          return;
        }

        final remaining = getRemainingTime(
          _activeTodo!,
        );

        // timer has expired
        if (remaining <= Duration.zero) {
          _handleExpiration();
          return;
        }

        notifyListeners();
      },
    );
  }

  // handles timer expiration
  void _handleExpiration() {
    _vibrateOnExpiration();

    if (_startedAt != null) {
      final now = DateTime.now();

      // adds the time actually worked
      final elapsed = now.difference(_startedAt!);

      _workedDuration += elapsed;
    }

    _stopTicker();

    _startedAt = null;
    _pausedRemainingTime = null;
    _hasAdditionalTimeSelected = false;

    _state = TodoTimerState.expired;

    notifyListeners();
  }

  // vibrates when time expired
  void _vibrateOnExpiration() {
    HapticFeedback.heavyImpact();

    Timer(const Duration(seconds: 1), () {
      HapticFeedback.heavyImpact();
    });

    Timer(const Duration(seconds: 2), () {
      HapticFeedback.heavyImpact();
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
