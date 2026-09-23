// dialog that shows timer for a single todo

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';

import 'package:protask_app/provider/timer_provider.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';
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

  // confettii
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  // finishes todo and stores the actual worked time
  Future<void> _finishTodo(
    
    TimerProvider timerProvider,
  ) async {
    // makes sure current running time is added
    timerProvider.finishTimer();

    final todoProvider = context.read<TodoProvider>();

    // gets the acural worked time in minutes
    final actualMinutes = timerProvider.workedDuration.inMinutes;

    debugPrint('actual: $actualMinutes');
    debugPrint(
      'Estimated: ${widget.todo.estimatedDuration ?? 0}',
    );

    // replaces estimated duration with the actual worked duration for this completed todo
    widget.todo.actualDuration = actualMinutes;

    // marks and saves the todo as completed
    await todoProvider.toggleTodo(
      widget.todo,
      true,
    );
    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

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
                                        _finishTodo(
                                          
                                          timerProvider,
                                        );
                                      },
                                    )
                              : TimerControls(
                                  key: const ValueKey('timer-controls'),
                                  timerProvider: timerProvider,
                                  todo: widget.todo,
                                  onFinish: () {
                                    _finishTodo(
                                      
                                      timerProvider,
                                    );
                                  }),
                        ),
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
