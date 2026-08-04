// data model that stores information about one todo
class TodoItem {
  String title;

  // stores whether the todo is completed
  bool isChecked;

  TodoItem({
    required this.title,
    this.isChecked = false,
  });
}
