import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/constants/todo_screen_constants.dart';
import 'package:protask_app/toDoList_startscreen/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:protask_app/provider/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // makes textfield active
  final TextEditingController _controller = TextEditingController();

  // METHODS
  //
  // checks if text exists and adds a new todo
  void addTodo() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    // adds todo to the central todo lists
    context.read<TodoProvider>().addTodo(
          _controller.text,
          scheduledDate: DateTime.now(),
        );

    // clears textfield after adding a todo
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // LOCAL VARIABLES
    //
    // TodoScreen rebuilds automatically whenever provider changes
    final todoProvider = context.watch<TodoProvider>();
    final openTodos = todoProvider.openTodos;
    final completedTodos = todoProvider.completedTodos;

    return Scaffold(
      // title "Today" and date below
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // displays the current page title
            const Text(
              TodoScreenConstants.title,
              style: TextStyle(
                  fontSize: AppConstants.titleFontSize,
                  fontWeight: AppConstants.subtitleFontWeight),
            ),

            // space between title and date
            const SizedBox(
              height: AppConstants.spacingMini,
            ),

            // displays current date
            Text(
              AppConstants.currentDate,
              style: const TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: AppConstants.subtitleFontWeight),
            ),

            // space before the todo list
            const SizedBox(
              height: AppConstants.spacingMedium,
            ),

            // displays todo list in the middle of the screen and handles checkbox changes
            // keeps todo list between the header and the input field
            Expanded(
              child: TodoList(
                openTodos: openTodos,
                completedTodos: completedTodos,
                onChanged: (value, todo) {
                  context.read<TodoProvider>().toggleTodo(todo, value!);
                },
                onDelete: (todo) {
                  context.read<TodoProvider>().deleteTodo(todo);
                },
                onReorder: (oldIndex, newIndex) {
                  context.read<TodoProvider>().reorderTodo(
                        oldIndex,
                        newIndex,
                      );
                },
              ),
            ),

            const SizedBox(
              height: AppConstants.spacingSmall,
            ),

            // input field for creating new todos
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width *
                    AppConstants.inputFieldWidthFactor,
                // eig so mediaquery versuchen hier
                height: AppConstants.inputFieldHeight,
                decoration: BoxDecoration(
                  borderRadius: AppConstants.inputFieldBorderRadius,
                  color: AppConstants.inputFieldColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: AppConstants.spacingMedium,
                    ),

                    // interactive textfield
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: TodoScreenConstants.hintText,
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          addTodo();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: addTodo,
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
