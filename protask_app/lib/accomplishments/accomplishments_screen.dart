import 'package:flutter/material.dart';
import 'package:protask_app/constants/accomplishments_constants.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/todo_constants.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/widgets/app_input_field.dart';
import 'package:provider/provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class AccomplishmentsScreen extends StatefulWidget {
  const AccomplishmentsScreen({super.key});

  @override
  State<AccomplishmentsScreen> createState() => _AccomplishmentsScreenState();
}

class _AccomplishmentsScreenState extends State<AccomplishmentsScreen> {
  // controls Add Accomplishment input field
  final TextEditingController _controller = TextEditingController();

  // currently selected accomplishment day
  DateTime _selectedDate = DateTime.now();

  // get weekday
  String _getWeekday(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[date.weekday - 1];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // METHOD
  // adds new accomplishment using the same Todo model as normal todos
  void addAccomplishment() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    // uses provider for adding completed todos
    context.read<TodoProvider>().addCompletedTodo(
          _controller.text,
          completedAt: _selectedDate,
        );
    _controller.clear();
  }

  // moves one day backwards or forwards
  void _changeDay(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(
        Duration(days: days),
      );
    });
  }

  // check if two dates are the same calendar day
  bool _isSameDay(DateTime? first, DateTime second) {
    if (first == null) {
      return false;
    }

    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  @override
  Widget build(BuildContext context) {
    // gets all todos from the central provider and only shows the completed todos
    final todoProvider = context.watch<TodoProvider>();
    // shows only completed todos; gets them directly from the provider
    final accomplishments = todoProvider.completedTodos.where((todo) {
      return _isSameDay(todo.completedAt, _selectedDate);
    }).toList();

    return Scaffold(
      body: Padding(
        padding: AppThemeConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isSameDay(_selectedDate, DateTime.now())
                  ? AccomplishmentsConstants.titleToday
                  : AccomplishmentsConstants.titleOtherDays,
              style: const TextStyle(
                fontSize: AppThemeConstants.titleFontSize,
                fontWeight: AppThemeConstants.titleFontWeight,
              ),
            ),

            // space between title and date
            const SizedBox(
              height: AppThemeConstants.spacingMini,
            ),

            // select date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _changeDay(-1);
                  },
                  icon: const Icon(Icons.chevron_left),
                ),

                // displays current date
                Text(
                  '${_getWeekday(_selectedDate)}, '
                  '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: AppThemeConstants.subtitleFontSize,
                    fontWeight: AppThemeConstants.subtitleFontWeight,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _changeDay(1);
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ],
            ),

            // space between date and accomplishment textfield
            const SizedBox(height: AppThemeConstants.spacingMedium),

            // Add Accomplishment input field

            // interactive textfield
            AppInputField(
              controller: _controller,
              hintText: AccomplishmentsConstants.hintText,
              onSubmitted: addAccomplishment,
            ),

            // space between accomplishment textfield and list
            const SizedBox(height: AppThemeConstants.spacingMedium),

            // displays all completed todos
            Expanded(
              child: accomplishments.isEmpty
                  ? const Center(
                      child: Text(
                        AccomplishmentsConstants.noAccomplishmentsText,
                        style: TextStyle(
                          fontSize: AppThemeConstants.bodyFontSize,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: accomplishments.length,
                      itemBuilder: (context, index) {
                        final todo = accomplishments[index];

                        // handles checking and deleteing todo
                        return Padding(
                          padding: TodoConstants.todoTileBottomSpacing,
                          child: TodoTile(
                            todo: todo,
                            onChanged: (value) {
                              todoProvider.toggleTodo(
                                todo,
                                value!,
                              );
                            },
                            onDelete: () {
                              todoProvider.deleteTodo(todo);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
