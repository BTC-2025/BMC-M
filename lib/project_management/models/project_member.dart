import 'package:flutter/material.dart';

enum ProjectRole { manager, developer, designer, analyst, tester, viewer }

extension ProjectRoleExtension on ProjectRole {
  String get label {
    switch (this) {
      case ProjectRole.manager:
        return 'Manager';
      case ProjectRole.developer:
        return 'Developer';
      case ProjectRole.designer:
        return 'Designer';
      case ProjectRole.analyst:
        return 'Analyst';
      case ProjectRole.tester:
        return 'Tester';
      case ProjectRole.viewer:
        return 'Viewer';
    }
  }

  Color get color {
    switch (this) {
      case ProjectRole.manager:
        return Colors.purple;
      case ProjectRole.developer:
        return Colors.blue;
      case ProjectRole.designer:
        return Colors.pink;
      case ProjectRole.analyst:
        return Colors.orange;
      case ProjectRole.tester:
        return Colors.teal;
      case ProjectRole.viewer:
        return Colors.grey;
    }
  }
}

class ProjectMember {
  final String id;
  final String projectId;
  final String userId;
  final String userName; // Denormalized for display ease in mock
  final String? avatarUrl;
  final ProjectRole role;
  final DateTime joinedAt;
  final double utilizationPercentage; // For Resource Allocation view

  ProjectMember({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.userName,
    this.avatarUrl,
    required this.role,
    required this.joinedAt,
    this.utilizationPercentage = 100.0,
  });
}
