class TimeEntry {
  final String id;
  final String projectId;
  final String? taskId; // Optional, can log time to project generally
  final String userId;
  final DateTime date;
  final double durationHours;
  final String description;
  final bool isBillable;

  TimeEntry({
    required this.id,
    required this.projectId,
    this.taskId,
    required this.userId,
    required this.date,
    required this.durationHours,
    required this.description,
    this.isBillable = true,
  });
}
