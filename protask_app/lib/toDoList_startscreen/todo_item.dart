// data model that stores information about one todo
class TodoItem {
  // unique ID for every todo
  final int id;

  // text displayed for todo
  String title;

  // stores whether the todo is completed
  bool isChecked;

  // stores when the todo was completed
  DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isChecked = false,
    this.completedAt,
  });

  //
  // SERIALIZATION
  //
  // converts TodoItem into a map so it can be saved locally
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  // creates TodoItem from saved data
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      isChecked: json['isChecked'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }
}
