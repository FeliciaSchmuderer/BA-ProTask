// data model that stores information about one todo
class TodoItem {
  // unique ID for every todo
  final int id;

  // text displayed for todo
  String title;

  // stores whether the todo is completed
  bool isChecked;

  // stores when the todo was completed
  // null means the todo has not been completed yet
  DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isChecked = false,
    this.completedAt,
  });
}
