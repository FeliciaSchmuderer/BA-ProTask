// data model that stores information about one todo
class TodoItem {
  // Unique ID for every todo
  final int id;

  String title;

  // stores whether the todo is completed
  bool isChecked;

  // stores when the todo was completed; with null the todo has not been completed yet
  DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isChecked = false,
    this.completedAt,
  });
}
