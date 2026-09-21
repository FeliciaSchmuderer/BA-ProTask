// dialog that shows timer for a single todo

import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/provider/timer_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/todo_timer/timer_additional_time.dart';
import 'package:protask_app/todo_timer/timer_clock.dart';
import 'package:protask_app/todo_timer/timer_controls.dart';
import 'package:protask_app/todo_timer/timer_countdown.dart';
import 'package:protask_app/todo_timer/timer_expired.dart';
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
class TimerDialogContent extends StatefulWidget {
  final TodoItem todo;

  const TimerDialogContent({
    super.key,
    required this.todo,
  });

  @override
  State<TimerDialogContent> createState() => _TimerDialogContentState();
}

class _TimerDialogContentState extends State<TimerDialogContent> {
  bool _showAdditionalTime = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        final remaining = timerProvider.getRemainingTime(widget.todo);

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
              builder: (context, constraints) {
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
                          availableHeight: constraints.maxHeight,
                        ),

                        const SizedBox(
                          height: TimerConstants.spacingSmall,
                        ),

                        // todo title
                        Text(
                          widget.todo.title,
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

                        // additional time animation
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            final slideAnimation = Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            );

                            return ClipRect(
                              child: SlideTransition(
                                position: slideAnimation,
                                child: child,
                              ),
                            );
                          },

                          // control buttons
                          child: timerProvider.state == TodoTimerState.expired
                              ? _showAdditionalTime
                                  ? TimerAdditionalTime(
                                      key: const ValueKey('additional-time'),
                                      // select additional time
                                      onSelected: (minutes) {
                                        timerProvider.addAdditionalTime(
                                          minutes,
                                        );
                                      },

                                      // back to expired screen
                                      onBack: () {
                                        setState(() {
                                          _showAdditionalTime = false;
                                        });
                                      },
                                      // starts selected additional time
                                      onStart: () {
                                        timerProvider.startAdditionalTime();
                                        setState(() {
                                          _showAdditionalTime = false;
                                        });
                                      },
                                    )
                                  : TimerExpired(
                                      key: const ValueKey('timer-expired'),
                                      // shows additional time screen
                                      onMoreTime: () {
                                        setState(() {
                                          _showAdditionalTime = true;
                                        });
                                      },
                                      // finishes todo timer
                                      onFinish: () {
                                        timerProvider.finishTimer();
                                        Navigator.of(context).pop();
                                      },
                                    )
                              : TimerControls(
                                  key: const ValueKey('timer-controls'),
                                  timerProvider: timerProvider,
                                  todo: widget.todo,
                                ),
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
