import 'package:flutter/material.dart';

enum TaskStatus { todo, inProgress, review, done }

enum TaskPriority { low, medium, high, critical }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.review:
        return 'Review';
      case TaskStatus.done:
        return 'Done';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.todo:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.review:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.critical:
        return 'Critical';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.critical:
        return Colors.red;
    }
  }
}

class ProjectTask {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final TaskStatus status;
  final TaskPriority priority;
  final String? assignedTo; // User ID
  final DateTime startDate;
  final DateTime dueDate;
  final List<String> tags;

  ProjectTask({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.assignedTo,
    required this.startDate,
    required this.dueDate,
    this.tags = const [],
  });
}
