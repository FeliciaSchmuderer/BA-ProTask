import 'package:flutter/material.dart';
import 'package:protask_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AccomplishmentsScreen extends StatefulWidget {
  const AccomplishmentsScreen({super.key});

  @override
  State<AccomplishmentsScreen> createState() => _AccomplishmentsScreenState();
}

class _AccomplishmentsScreenState extends State<AccomplishmentsScreen> {
  // makes textfield active
  final TextEditingController _controller = TextEditingController();

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
    final accomplishments = context
        .watch<TodoProvider>()
        .todos
        .where((todo) => todo.isChecked)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Todays Accomplishments",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          // space between title and date
          const SizedBox(
            height: 3,
          ),

          // displays current date
          const Text(
            "Samstag, 15.08.2026",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),

          // space between date and accomplishment textfield

          const SizedBox(
            height: 20,
          ),

          // Accomplishment textfield
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[350],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),

                const Icon(
                  Icons.add,
                ),

                const SizedBox(
                  width: 10,
                ),

                // interactive textfield
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Add Accomplishment",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      addAccomplishment();
                    },
                  ),
                ),

                IconButton(
                  onPressed: addAccomplishment,
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),

          // space between accomplishment textfield and list
          const SizedBox(
            height: 20,
          ),

          // accomplishment list
          Expanded(
            child: ListView.builder(
              itemCount: accomplishments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_box_rounded,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        accomplishments[index].title,
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
