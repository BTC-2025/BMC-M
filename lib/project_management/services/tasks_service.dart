import '../models/task.dart';

class TasksService {
  static final TasksService _instance = TasksService._internal();

  factory TasksService() {
    return _instance;
  }

  TasksService._internal();

  // Mock Data
  final List<ProjectTask> _tasks = [
    // Tasks for Mobile App Redesign (proj_1)
    ProjectTask(
      id: 'task_1',
      projectId: 'proj_1',
      title: 'Design System Update',
      description: 'Update the Figma design system with new brand colors.',
      status: TaskStatus.done,
      priority: TaskPriority.high,
      assignedTo: 'emp_2',
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['Design', 'UI'],
    ),
    ProjectTask(
      id: 'task_2',
      projectId: 'proj_1',
      title: 'Login Screen Implementation',
      description: 'Implement the new login flow with biometric auth.',
      status: TaskStatus.inProgress,
      priority: TaskPriority.critical,
      assignedTo: 'emp_1',
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      dueDate: DateTime.now().add(const Duration(days: 3)),
      tags: ['Dev', 'Auth'],
    ),
    ProjectTask(
      id: 'task_3',
      projectId: 'proj_1',
      title: 'API Integration',
      description: 'Connect the dashboard to the backend API.',
      status: TaskStatus.todo,
      priority: TaskPriority.high,
      assignedTo: 'emp_3',
      startDate: DateTime.now().add(const Duration(days: 2)),
      dueDate: DateTime.now().add(const Duration(days: 7)),
      tags: ['Backend', 'API'],
    ),

    // Tasks for Website Migration (proj_2)
    ProjectTask(
      id: 'task_4',
      projectId: 'proj_2',
      title: 'Database Backup',
      description: 'Perform a full backup of the legacy database.',
      status: TaskStatus.done,
      priority: TaskPriority.critical,
      assignedTo: 'emp_3',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      dueDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
    ProjectTask(
      id: 'task_5',
      projectId: 'proj_2',
      title: 'DNS Propagation Check',
      description: 'Verify DNS settings for the new domain.',
      status: TaskStatus.inProgress,
      priority: TaskPriority.medium,
      assignedTo: 'emp_2',
      startDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  Future<List<ProjectTask>> getTasksByProjectId(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _tasks.where((t) => t.projectId == projectId).toList();
  }

  Future<List<ProjectTask>> getAllTasks() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.from(_tasks);
  }

  Future<void> addTask(ProjectTask task) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _tasks.add(task);
  }

  Future<void> updateTask(ProjectTask task) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _tasks.removeWhere((t) => t.id == id);
  }
}
