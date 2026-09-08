import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_constants.dart';
import 'package:protask_app/helpers/app_date_picker.dart';
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

  DateTime _selectedScheduledDate = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  Color _getPriorityColor(TodoPriority priority) {
    switch (priority) {
      case TodoPriority.a:
        return Colors.red.shade200;
      case TodoPriority.b:
        return Colors.orange.shade200;
      case TodoPriority.c:
        return Colors.yellow.shade200;
      case TodoPriority.d:
        return Colors.blue.shade200;
    }
  }

  Color _getPriorityBorderColor(TodoPriority priority) {
    switch (priority) {
      case TodoPriority.a:
        return Colors.red.shade700;
      case TodoPriority.b:
        return Colors.orange.shade700;
      case TodoPriority.c:
        return Colors.yellow.shade700;
      case TodoPriority.d:
        return Colors.blue.shade700;
    }
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
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(priority),
                      border: Border.all(
                        color: _getPriorityBorderColor(priority),
                        width: isSelected ? 3 : 1,
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

            const SizedBox(
              height: 40,
            ),

            // set scheduled date
            const Text(
              'When?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedScheduledDate = DateTime.now();
                    });
                  },
                  child: const Text('Today'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedScheduledDate = DateTime.now().add(
                        const Duration(days: 1),
                      );
                    });
                  },
                  child: const Text('Tomorrow'),
                ),
                ElevatedButton(
                  onPressed: _pickScheduledDate,
                  child: const Text('Pick Date'),
                ),
              ],
            ),

            const SizedBox(height: 40),

// create button provisorisch
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
