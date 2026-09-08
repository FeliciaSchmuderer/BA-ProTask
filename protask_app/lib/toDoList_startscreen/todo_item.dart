// data model that stores information about one todo

// defining the four priority levels based on the Eisenhower principle
enum TodoPriority {
  a,
  b,
  c,
  d,
}

class TodoItem {
  // unique ID for every todo
  final int id;

  // text displayed for todo
  String title;

  // stores whether the todo is completed
  bool isChecked;

  // stores when the todo was completed
  DateTime? completedAt;

  DateTime? scheduledDate;

  DateTime? deadlineDate;

  TodoPriority? priority;

  int? estimatedDuration;

  TodoItem({
    required this.id,
    required this.title,
    this.isChecked = false,
    this.completedAt,
    this.scheduledDate,
    this.deadlineDate,
    this.priority,
    this.estimatedDuration,
  });

  // SERIALIZATION / JSON
  //
  // converts TodoItem into a map so it can be saved locally
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked,
      'completedAt': completedAt?.toIso8601String(),
      'scheduledDate': scheduledDate?.toIso8601String(),
      'deadlineDate': deadlineDate?.toIso8601String(),
      'priority': priority?.name,
      'estimatedDuration': estimatedDuration,
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
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'])
          : null,
      deadlineDate: json['deadlineDate'] != null
          ? DateTime.parse(json['deadlineDate'])
          : null,
      priority: json['priority'] != null
          ? TodoPriority.values.firstWhere(
              (priority) => priority.name == json['priority'],
            )
          : null,
      estimatedDuration: json['estimatedDuration'],
    );
  }
}
