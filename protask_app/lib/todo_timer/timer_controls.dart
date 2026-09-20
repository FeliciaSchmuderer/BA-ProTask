import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/provider/timer_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/todo_timer/timer_control_button.dart';
import 'package:protask_app/todo_timer/timer_finish_button.dart';

class TimerControls extends StatelessWidget {
  final TimerProvider timerProvider;
  final TodoItem todo;

  const TimerControls({
    super.key,
    required this.timerProvider,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // on larger screens
        if (constraints.maxWidth >= 430) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TimerControlButton(
                      icon: Icons.play_arrow_rounded,
                      label: 'Start',
                      onPressed: () {
                        timerProvider.startTimer(todo);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: TimerConstants.spacingSmall,
                  ),
                  Expanded(
                    child: TimerControlButton(
                      icon: Icons.pause_rounded,
                      label: 'Pause',
                      onPressed: () {
                        timerProvider.pauseTimer();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: TimerConstants.spacingSmall,
                  ),
                  Expanded(
                    child: TimerControlButton(
                      icon: Icons.stop_rounded,
                      label: 'Stop',
                      onPressed: () {
                        timerProvider.stopTimer();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TimerConstants.spacingMedium,
              ),
              TimerFinishButton(
                onPressed: () {
                  timerProvider.finishTimer();

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }

        // layout on smaller screens !
        return Column(
          children: [
            // Start + Pause
            Row(
              children: [
                Expanded(
                  child: TimerControlButton(
                    icon: Icons.play_arrow_rounded,
                    label: 'Start',
                    onPressed: () {
                      timerProvider.startTimer(todo);
                    },
                  ),
                ),
                const SizedBox(
                  width: TimerConstants.spacingSmall,
                ),
                Expanded(
                  child: TimerControlButton(
                    icon: Icons.pause_rounded,
                    label: 'Pause',
                    onPressed: () {
                      timerProvider.pauseTimer();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TimerConstants.spacingMedium,
            ),

            // Stop + Finish
            Row(
              children: [
                Expanded(
                  child: TimerControlButton(
                    icon: Icons.stop_rounded,
                    label: 'Stop',
                    onPressed: () {
                      timerProvider.stopTimer();
                    },
                  ),
                ),
                const SizedBox(
                  width: TimerConstants.spacingSmall,
                ),
                Expanded(
                  child: TimerFinishButton(
                    fullWidth: false,
                    onPressed: () {
                      timerProvider.finishTimer();

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
