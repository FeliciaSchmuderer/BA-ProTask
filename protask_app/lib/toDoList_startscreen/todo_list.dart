import 'package:flutter/material.dart';
import 'package:protask_app/toDoList_startscreen/todo_item.dart';
import 'package:protask_app/toDoList_startscreen/todo_tile.dart';

class TodoList extends StatelessWidget {
// CONSTANCES

  // list of all todo items
  final List<TodoItem> openTodos;
  final List<TodoItem> completedTodos;

  // Function to update the state of a todo (checked or not)
  final Function(bool?, TodoItem) onChanged;
  // function to delete a todo
  final Function(TodoItem) onDelete;

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
    // enables to drag a todo

    return CustomScrollView(
      slivers: [
// open todos

        SliverReorderableList(
          itemCount: openTodos.length,
          onReorder: onReorder,
          // dragBoundaryProvider: (context) {
          // final renderBox = context.findRenderObject() as RenderBox;
          //return renderBox.localToGlobal(Offset.zero) & renderBox.size;
          //},
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

////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////
        ///
        ///
        // completed todos
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

    /* return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: todos.length,
      onReorder: onReorder,
      itemBuilder: (context, index) {
        final todo = todos[index];

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
    ); */
  }
}
