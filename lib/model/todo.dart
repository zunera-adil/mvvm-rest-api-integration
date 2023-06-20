class Todo {
  final String id;
  final String taskTitle;
  final String taskDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Todo({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'task_title': taskTitle,
      'task_description': taskDescription,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      taskTitle: json['task_title'],
      taskDescription: json['task_description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
