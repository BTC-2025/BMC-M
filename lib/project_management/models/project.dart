import 'package:flutter/material.dart';

enum ProjectStatus { planned, inProgress, onHold, completed, cancelled }

enum ProjectType { fixedCost, timeAndMaterial }

enum ProjectPriority { low, medium, high }

extension ProjectStatusExtension on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.planned:
        return 'Planned';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.onHold:
        return 'On Hold';
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case ProjectStatus.planned:
        return Colors.blueGrey;
      case ProjectStatus.inProgress:
        return Colors.blue;
      case ProjectStatus.onHold:
        return Colors.orange;
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.cancelled:
        return Colors.red;
    }
  }
}

extension ProjectPriorityExtension on ProjectPriority {
  String get label {
    switch (this) {
      case ProjectPriority.low:
        return 'Low';
      case ProjectPriority.medium:
        return 'Medium';
      case ProjectPriority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case ProjectPriority.low:
        return Colors.green;
      case ProjectPriority.medium:
        return Colors.orange;
      case ProjectPriority.high:
        return Colors.red;
    }
  }
}

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final ProjectStatus status;
  final ProjectType type;
  final ProjectPriority priority;
  final double budget;
  final String clientId; // Link to CRM Customer
  final String managerId; // Link to HRM Employee
  final double completionPercentage;
  final List<String> tags;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.type,
    required this.priority,
    required this.budget,
    required this.clientId,
    required this.managerId,
    this.completionPercentage = 0.0,
    this.tags = const [],
  });
}
