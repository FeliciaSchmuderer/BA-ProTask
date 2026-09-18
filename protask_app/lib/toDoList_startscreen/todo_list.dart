import 'package:flutter/material.dart';
import 'package:protask_app/constants/todo_constants.dart';
import 'package:protask_app/constants/todo_screen_constants.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class TodoList extends StatelessWidget {
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
        // open todos
        SliverReorderableList(
          itemCount: openTodos.length,
          onReorderItem: onReorder,

          // adds shadow to todo while being dragged
          proxyDecorator: (child, index, animation) {
            return Material(
              color: Colors.transparent,
              elevation: TodoConstants.dragElevation,
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final todo = openTodos[index];

            return ReorderableDelayedDragStartListener(
              key: ValueKey(todo.id),
              index: index,
              child: Padding(
                padding: TodoConstants.todoTileBottomSpacing,
                child: TodoTile(
                  todo: todo,
                  onChanged: (value) {
                    onChanged(value, todo);
                  },
                  onDelete: () {
                    onDelete(todo);
                  },
                ),
              ),
            );
          },
        ),

        // completed section
        if (completedTodos.isNotEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: TodoScreenConstants.completedPadding,
              child: Text(
                TodoScreenConstants.completedText,
                style: TextStyle(
                  fontSize: TodoScreenConstants.completedFontSize,
                  fontWeight: TodoScreenConstants.completedFontWeight,
                ),
              ),
            ),
          ),

        // completed todos
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final todo = completedTodos[index];

              return Padding(
                padding: TodoConstants.todoTileBottomSpacing,
                child: TodoTile(
                  key: ValueKey(todo.id),
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
            childCount: completedTodos.length,
          ),
        ),
      ],
    );
  }
}
