import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/provider/timer_provider.dart';

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
        return 'Ready';

      case TodoTimerState.running:
        return 'Timer is running';

      case TodoTimerState.paused:
        return 'paused';

      case TodoTimerState.stopped:
        return 'Stopped';

      case TodoTimerState.finished:
        return 'Finished';

      case TodoTimerState.expired:
        return 'Time expired';
    }
  }
}
