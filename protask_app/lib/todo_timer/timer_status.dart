import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/provider/timer_provider.dart';

// handels status of the control buttons in the timer dialog
class TimerStatus extends StatelessWidget {
  final TodoTimerState state;

  const TimerStatus({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      _getStatusText(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: TimerConstants.statusFontSize,
        color: TimerConstants.statusColor,
      ),
    );
  }

  String _getStatusText() {
    switch (state) {
      case TodoTimerState.idle:
        return TimerConstants.readyStatus;

      case TodoTimerState.running:
        return TimerConstants.runningStatus;

      case TodoTimerState.paused:
        return TimerConstants.pausedStatus;

      case TodoTimerState.stopped:
        return TimerConstants.stoppedStatus;

      case TodoTimerState.finished:
        return TimerConstants.finishStatus;

      case TodoTimerState.expired:
        return TimerConstants.expiredStatus;
    }
  }
}
