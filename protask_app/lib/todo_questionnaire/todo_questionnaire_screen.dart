import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void createTodo() {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    context.read<TodoProvider>().addTodo(
          _controller.text,
          // scheduledDate: DateTime.now(),
          priority: _selectedPriority,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. write down todo
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                hintText: 'ToDo',
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // 2. set priorities
            const Text(
              'Priority',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 35),

            // A B C D
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: TodoPriority.values.map((priority) {
                final isSelected = _selectedPriority == priority;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPriority = priority;
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        priority.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // create button provisorisch
            const SizedBox(
              height: 40,
            ),

            ElevatedButton(
              onPressed: createTodo,
              child: const Text('Create Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
