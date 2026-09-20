// dialog that shows timer for a single todo

import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/provider/timer_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/todo_timer/timer_clock.dart';
import 'package:protask_app/todo_timer/timer_controls.dart';
import 'package:protask_app/todo_timer/timer_countdown.dart';
import 'package:protask_app/todo_timer/timer_status.dart';
import 'package:provider/provider.dart';

class TimerDialog extends StatelessWidget {
  final TodoItem todo;

  const TimerDialog({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: TimerDialogContent(todo: todo),
    );
  }
}

//actual UI of the timer dialog
class TimerDialogContent extends StatelessWidget {
  final TodoItem todo;

  const TimerDialogContent({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        final remaining = timerProvider.getRemainingTime(todo);

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: TimerConstants.dialogHorizontalPadding,
            vertical: TimerConstants.dialogVerticalPadding,
          ),
          backgroundColor: TimerConstants.dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              TimerConstants.dialogRadius,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, contraints) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: TimerConstants.maxDialogWidth,
                    maxHeight: TimerConstants.maxDialogHeight,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(
                      TimerConstants.spacingLarge,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // clock
                        TimerClock(
                          isRunning: timerProvider.isRunning,
                        ),

                        const SizedBox(
                          height: TimerConstants.spacingLarge,
                        ),

                      
                      // countdown
                        TimerCountdown(
                          duration: remaining,
                          availableHeight: contraints.maxHeight,
                        ),

                        const SizedBox(
                          height: TimerConstants.spacingSmall,
                        ),

                        // todo title
                        Text(
                          todo.title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: TimerConstants.todoTitleFontSize,
                            color: TimerConstants.todotileColor,
                          ),
                        ),

                        const SizedBox(
                          height: TimerConstants.spacingMedium,
                        ),

                        // status
                        TimerStatus(
                          state: timerProvider.state,
                        ),

                        const SizedBox(
                          height: TimerConstants.spacingLarge,
                        ),

                        // control buttons
                        TimerControls(
                          timerProvider: timerProvider,
                          todo: todo,
                        )
                        
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
