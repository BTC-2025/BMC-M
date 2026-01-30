import '../models/time_entry.dart';

class TimeTrackingService {
  static final TimeTrackingService _instance = TimeTrackingService._internal();

  factory TimeTrackingService() {
    return _instance;
  }

  TimeTrackingService._internal();

  final List<TimeEntry> _entries = [
    // Mock Data for Project 1
    TimeEntry(
      id: 'time_1',
      projectId: 'proj_1',
      taskId: 'task_1',
      userId: 'emp_2', // Jane
      date: DateTime.now().subtract(const Duration(days: 2)),
      durationHours: 4.5,
      description: 'Worked on Figma design updates',
    ),
    TimeEntry(
      id: 'time_2',
      projectId: 'proj_1',
      taskId: 'task_2',
      userId: 'emp_1', // John
      date: DateTime.now().subtract(const Duration(days: 1)),
      durationHours: 6.0,
      description: 'Implemented login screen logic',
    ),
    TimeEntry(
      id: 'time_3',
      projectId: 'proj_1',
      taskId: 'task_2',
      userId: 'emp_1', // John
      date: DateTime.now(),
      durationHours: 2.0,
      description: 'Fixed login bugs',
    ),
  ];

  Future<List<TimeEntry>> getEntriesByProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _entries.where((e) => e.projectId == projectId).toList();
  }

  Future<List<TimeEntry>> getAllEntries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_entries);
  }

  Future<void> addEntry(TimeEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _entries.add(entry);
  }
}
