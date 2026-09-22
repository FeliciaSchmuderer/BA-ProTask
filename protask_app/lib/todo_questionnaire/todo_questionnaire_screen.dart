import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/helpers/app_date_picker.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/helpers/app_time_picker.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';
import 'package:protask_app/widgets/todo_date_button.dart';
import 'package:protask_app/widgets/todo_deadline_button.dart';
import 'package:protask_app/widgets/todo_duration_button.dart';
import 'package:protask_app/widgets/todo_priority_button.dart';
import 'package:provider/provider.dart';
import 'package:protask_app/widgets/buffer_section.dart';

class TodoQuestionnaireScreen extends StatefulWidget {
  final TodoItem? todo;

  const TodoQuestionnaireScreen({
    super.key,
    this.todo,
  });

  @override
  State<TodoQuestionnaireScreen> createState() =>
      _TodoQuestionnaireScreenState();
}

class _TodoQuestionnaireScreenState extends State<TodoQuestionnaireScreen> {
  final TextEditingController _controller = TextEditingController();

  TodoPriority? _selectedPriority;
  DateTime? _selectedScheduledDate;
  DateTime? _selectedDeadlineDate;
  TimeOfDay? _selectedDeadlineTime;
  int? _selectedDuration;

  @override
  void initState() {
    super.initState();

    final todo = widget.todo;

    if (todo != null) {
      _controller.text = todo.title;
      _selectedPriority = todo.priority;
      _selectedScheduledDate = todo.scheduledDate;
      _selectedDeadlineDate = todo.deadlineDate;
      _selectedDeadlineTime = todo.deadlineTime;
      _selectedDuration = todo.estimatedDuration;
    }
  }

  // checks if two date represent the same calendar day
  bool _isSameDay(DateTime? first, DateTime second) {
    if (first == null) {
      return false;
    }
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  // checks if the selected date is neither today nor tomorrow
  bool _isOtherDate(DateTime? date) {
    if (date == null) {
      return false;
    }
    return !_isSameDay(date, DateTime.now()) &&
        !_isSameDay(
          date,
          DateTime.now().add(
            const Duration(days: 1),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // opens date picker and stores selected date
  Future<void> _pickScheduledDate() async {
    final pickedDate = await Appdatepicker.selectDate(
      context,
      _selectedScheduledDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedScheduledDate = pickedDate;
      });
    }
  }

  // opens date picker for deadline
  Future<void> _pickDeadlineDate() async {
    final pickedDate =
        await Appdatepicker.selectDate(context, _selectedDeadlineDate);

    if (pickedDate != null) {
      setState(() {
        _selectedDeadlineDate = pickedDate;
      });
    }
  }

  // opens time picker for deadline
  Future<void> _pickDeadlineTime() async {
    final pickedTime = await AppTimePicker.selectTime(
      context,
      _selectedDeadlineTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedDeadlineTime = pickedTime;
      });
    }
  }

  // removes deadline date and time
  void _removeDeadline() {
    setState(() {
      _selectedDeadlineDate = null;
      _selectedDeadlineTime = null;
    });
  }

  // opens duration picker and stores selected duration
  Future<void> _pickDuration() async {
    final duration = await AppDurationPicker.selectDuration(
      context,
      _selectedDuration,
    );

    if (duration != null) {
      setState(() {
        _selectedDuration = duration > 0 ? duration : null;
      });
    }
  }

  // removes selected duration
  void _removeDuration() {
    setState(() {
      _selectedDuration = null;
    });
  }

  Future<void> saveTodo() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    final todoProvider = context.read<TodoProvider>();

    if (widget.todo == null) {
      await todoProvider.addTodo(
        _controller.text.trim(),
        scheduledDate: _selectedScheduledDate,
        deadlineDate: _selectedDeadlineDate,
        deadlineTime: _selectedDeadlineTime,
        priority: _selectedPriority,
        estimatedDuration: _selectedDuration,
      );
    } else {
      await todoProvider.updateTodo(
        widget.todo!,
        title: _controller.text.trim(),
        scheduledDate: _selectedScheduledDate,
        deadlineDate: _selectedDeadlineDate,
        deadlineTime: _selectedDeadlineTime,
        priority: _selectedPriority,
        estimatedDuration: _selectedDuration,
      );
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeConstants.popupColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(
              QuestionnaireConstants.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. write down todo
                const SizedBox(
                  height: QuestionnaireConstants.todoTopSpacing,
                ),

                TextField(
                  controller: _controller,
                  cursorColor: AppThemeConstants.textColor,
                  style: const TextStyle(
                    fontSize: QuestionnaireConstants.todoFontSize,
                    fontWeight: QuestionnaireConstants.todoFontWeight,
                  ),
                  decoration: const InputDecoration(
                    hintText: QuestionnaireConstants.todoHintText,
                    hintStyle: TextStyle(
                      fontSize: QuestionnaireConstants.todoHintFontSize,
                      fontWeight: QuestionnaireConstants.todoFontWeight,
                      color: AppThemeConstants.hintTextColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppThemeConstants.textColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: AppThemeConstants.textColor,
                    )),
                  ),
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // set scheduled date - when?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      QuestionnaireConstants.whenTitle,
                      style: TextStyle(
                        fontSize: QuestionnaireConstants.sectionTitleFontSize,
                        fontWeight:
                            QuestionnaireConstants.sectionTitleFontWeight,
                      ),
                    ),

                    const SizedBox(
                      height: AppThemeConstants.spacingMedium,
                    ),

                    // Today - Tomorrow - Pick Date
                    Wrap(
                      spacing: AppThemeConstants.spacingSmall,
                      runSpacing: AppThemeConstants.spacingSmall,
                      children: [
                        Expanded(
                          child: TodoDateButton(
                            title: QuestionnaireConstants.dateTextToday,
                            date: DateTime.now(),
                            isSelected: _isSameDay(
                              _selectedScheduledDate,
                              DateTime.now(),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedScheduledDate = DateTime.now();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: TodoDateButton(
                            title: QuestionnaireConstants.dateTextTomorrow,
                            date: DateTime.now().add(
                              const Duration(days: 1),
                            ),
                            isSelected: _isSameDay(
                              _selectedScheduledDate,
                              DateTime.now().add(
                                const Duration(days: 1),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedScheduledDate = DateTime.now().add(
                                  const Duration(days: 1),
                                );
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: TodoDateButton(
                            title: QuestionnaireConstants.dateTextPick,
                            date: _isOtherDate(_selectedScheduledDate)
                                ? _selectedScheduledDate
                                : null,
                            isSelected: _isOtherDate(
                              _selectedScheduledDate,
                            ),
                            onPressed: _pickScheduledDate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // 2. deadline
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      QuestionnaireConstants.deadlineTitle,
                      style: TextStyle(
                        fontSize: QuestionnaireConstants.sectionTitleFontSize,
                        fontWeight:
                            QuestionnaireConstants.sectionTitleFontWeight,
                      ),
                    ),

                    const SizedBox(
                      height: QuestionnaireConstants.titleContentspacing,
                    ),

                    // deadline buttons: pick date - pick time - remove deadline
                    Wrap(
                      spacing: AppThemeConstants.spacingSmall,
                      runSpacing: AppThemeConstants.spacingSmall,
                      children: [
                        // deadline date and time button
                        TodoDeadlineButton(
                          text: QuestionnaireConstants.deadlineTextPick,
                          date: _selectedDeadlineDate,
                          time: null,
                          onPressed: _pickDeadlineDate,
                        ),

                        if (_selectedDeadlineDate != null)
                          TodoDeadlineButton(
                            text: QuestionnaireConstants.deadlineTimeTextPick,
                            date: null,
                            time: _selectedDeadlineTime,
                            onPressed: _pickDeadlineTime,
                          ),
                      ],
                    ),

                    if (_selectedDeadlineDate != null)
                      TextButton(
                        onPressed: _removeDeadline,
                        style: TextButton.styleFrom(
                          foregroundColor: AppThemeConstants.hintTextColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          QuestionnaireConstants.removeDeadlineText,
                        ),
                      ),
                  ],
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // 3. set priorities
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      QuestionnaireConstants.priorityTitle,
                      style: TextStyle(
                        fontSize: QuestionnaireConstants.sectionTitleFontSize,
                        fontWeight:
                            QuestionnaireConstants.sectionTitleFontWeight,
                      ),
                    ),

                    const SizedBox(
                      height: QuestionnaireConstants.titleContentspacing,
                    ),

                    // priority buttons: A B C D
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: TodoPriority.values.map((priority) {
                        return Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: TodoPriorityButton(
                              priority: priority,
                              isSelected: _selectedPriority == priority,
                              onPressed: () {
                                setState(() {
                                  _selectedPriority = priority;
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // remove priority button
                    if (_selectedPriority != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedPriority = null;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppThemeConstants.hintTextColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          QuestionnaireConstants.removePriorityTitle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // 4. Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      QuestionnaireConstants.durationTitle,
                      style: TextStyle(
                        fontSize: QuestionnaireConstants.sectionTitleFontSize,
                        fontWeight:
                            QuestionnaireConstants.sectionTitleFontWeight,
                      ),
                    ),
                    const SizedBox(
                      height: QuestionnaireConstants.titleContentspacing,
                    ),
                    TodoDurationButton(
                      duration: _selectedDuration,
                      onPressed: _pickDuration,
                    ),
                    if (_selectedDuration != null)
                      TextButton(
                        onPressed: _removeDuration,
                        style: TextButton.styleFrom(
                          foregroundColor: AppThemeConstants.hintTextColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          QuestionnaireConstants.removeDurationText,
                        ),
                      ),
                  ],
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // 5. buffer area
                BufferSection(
                  selectedDate: _selectedScheduledDate,
                  selectedDuration: _selectedDuration,
                ),

                const SizedBox(
                  height: QuestionnaireConstants.sectionSpacing,
                ),

                // create button
                Center(
                  child: ElevatedButton(
                    onPressed: saveTodo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            QuestionnaireConstants.createButtonHorizonal,
                        vertical: QuestionnaireConstants.createButtonVertical,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                            QuestionnaireConstants.createButtonRadius),
                      ),
                    ),
                    child: Text(
                      widget.todo == null
                          ? QuestionnaireConstants.createTodoText
                          : QuestionnaireConstants.saveTodoText,
                      style: const TextStyle(
                        fontSize: QuestionnaireConstants.createButtonFontSize,
                        // color: AppThemeConstants.accentColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppThemeConstants.spacingSmall,
                ),
              ],
            ),
          ),

          // X to close the questionnaire on the upper right
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: AppThemeConstants.textColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
