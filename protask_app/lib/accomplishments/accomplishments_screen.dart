import 'package:flutter/material.dart';
import 'package:protask_app/constants/accomplishments_constants.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
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
    context.read<TodoProvider>().addCompletedTodo(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // gets all todos from the central provider and only shows the completed todos
    final todoProvider = context.watch<TodoProvider>();
    // shows only completed todos; gets them directly from the provider
    final accomplishments = todoProvider.completedTodos;

    return Scaffold(
      body: Padding(
        padding: AppThemeConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AccomplishmentsConstants.title,
              style: TextStyle(
                fontSize: AppThemeConstants.titleFontSize,
                fontWeight: AppThemeConstants.titleFontWeight,
              ),
            ),

            // space between title and date
            const SizedBox(height: AppThemeConstants.spacingMini),

            // displays current date
            Text(
              AppThemeConstants.currentDate,
              style: const TextStyle(
                fontSize: AppThemeConstants.subtitleFontSize,
                fontWeight: AppThemeConstants.subtitleFontWeight,
              ),
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
              child: ListView.builder(
                itemCount: accomplishments.length,
                itemBuilder: (context, index) {
                  final todo = accomplishments[index];

                  // handles checking and deleteing todo
                  return TodoTile(
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
