import 'package:flutter/material.dart';
import 'package:protask_app/constants/questionnaire_constants.dart';
import 'package:protask_app/helpers/app_date_picker.dart';
import 'package:protask_app/helpers/app_time_picker.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/widgets/todo_date_button.dart';
import 'package:protask_app/widgets/todo_priority_button.dart';
import 'package:provider/provider.dart';

class TodoQuestionnaireScreen extends StatefulWidget {
  const TodoQuestionnaireScreen({super.key});

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

  void createTodo() {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    context.read<TodoProvider>().addTodo(
          _controller.text,
          priority: _selectedPriority,
          scheduledDate: _selectedScheduledDate,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(QuestionnaireConstants.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. write down todo
            const SizedBox(height: QuestionnaireConstants.todoTopSpacing),
            TextField(
              controller: _controller,
              style: const TextStyle(
                fontSize: QuestionnaireConstants.todoFontSize,
                fontWeight: QuestionnaireConstants.todoFontWeight,
              ),
              decoration: const InputDecoration(
                hintText: QuestionnaireConstants.todoHintText,
                hintStyle: TextStyle(
                  fontSize: QuestionnaireConstants.todoHintFontSize,
                  fontWeight: QuestionnaireConstants.todoFontWeight,
                ),
                enabledBorder: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: QuestionnaireConstants.sectionSpacing,
            ),

            // 2. set priorities
            const Text(
              QuestionnaireConstants.priorityTitle,
              style: TextStyle(
                fontSize: QuestionnaireConstants.sectionTitleFontSize,
                fontWeight: QuestionnaireConstants.sectionTitleFontWeight,
              ),
            ),

            const SizedBox(height: QuestionnaireConstants.titleContentspacing),

            // A B C D
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: TodoPriority.values.map((priority) {
                return TodoPriorityButton(
                  priority: priority,
                  isSelected: _selectedPriority == priority,
                  onPressed: () {
                    setState(() {
                      _selectedPriority = priority;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(
              height: QuestionnaireConstants.sectionSpacing,
            ),

            // set scheduled date
            const Text(
              QuestionnaireConstants.whenTitle,
              style: TextStyle(
                fontSize: QuestionnaireConstants.sectionTitleFontSize,
                fontWeight: QuestionnaireConstants.sectionTitleFontWeight,
              ),
            ),

            const SizedBox(
              height: QuestionnaireConstants.titleContentspacing,
            ),

            // Today - Tomorrow - Pick Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TodoDateButton(
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
                TodoDateButton(
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
                TodoDateButton(
                  title: QuestionnaireConstants.dateTextPick,
                  date: _isOtherDate(_selectedScheduledDate)
                      ? _selectedScheduledDate
                      : null,
                  isSelected: _isOtherDate(_selectedScheduledDate),
                  onPressed: _pickScheduledDate,
                ),
              ],
            ),

            const SizedBox(height: QuestionnaireConstants.sectionSpacing),

            // create button provisorisch
            ElevatedButton(
              onPressed: createTodo,
              child: const Text(QuestionnaireConstants.createTodoText),
            ),
          ],
        ),
      ),
    );
  }
}
