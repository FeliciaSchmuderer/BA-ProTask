import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class TodoList extends StatelessWidget {
  //
  // FIELDS
  //

  final List<TodoItem> openTodos;
  final List<TodoItem> completedTodos;

  // Callbacks to update the state of a todo (checked or not)
  final Function(bool?, TodoItem) onChanged;
  final Function(TodoItem) onDelete;
  // called when an open todo is reordered
  final Function(int, int) onReorder;

  const TodoList({
    super.key,
    required this.openTodos,
    required this.completedTodos,
    required this.onChanged,
    required this.onDelete,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    // scrollable list of todo tiles
    return CustomScrollView(
      slivers: [
        //
        // OPEN TODOS
        //
        SliverReorderableList(
          itemCount: openTodos.length,
          onReorderItem: onReorder,
          // drag boundary is provided by th DragBoundary surrounding this list in TodoScreen
          proxyDecorator: (child, index, animation) {
            return Material(
              elevation: 4,
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final todo = openTodos[index];

            return ReorderableDelayedDragStartListener(
              key: ValueKey(todo.id),
              index: index,
              child: TodoTile(
                todo: todo,
                onChanged: (value) {
                  onChanged(value, todo);
                },
                onDelete: () {
                  onDelete(todo);
                },
              ),
            );
          },
        ),

        //
        // COMPLETED SECTION
        //
        if (completedTodos.isNotEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Text(
                "Completed",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),

        //
        // COMPLETED TODOS
        //
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final todo = completedTodos[index];

              return TodoTile(
                key: ValueKey(todo.id),
                todo: todo,
                onChanged: (value) {
                  onChanged(value, todo);
                },
                onDelete: () {
                  onDelete(todo);
                },
              );
            },
            childCount: completedTodos.length,
          ),
        ),
      ],
    );
  }
}
