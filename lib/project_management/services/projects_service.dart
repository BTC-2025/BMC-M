import '../models/project.dart';

class ProjectsService {
  static final ProjectsService _instance = ProjectsService._internal();

  factory ProjectsService() {
    return _instance;
  }

  ProjectsService._internal();

  // Mock Data
  final List<Project> _projects = [
    Project(
      id: 'proj_1',
      name: 'Mobile App Redesign',
      description:
          'Redesigning the corporate mobile application for better UX.',
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 60)),
      status: ProjectStatus.inProgress,
      type: ProjectType.fixedCost,
      priority: ProjectPriority.high,
      budget: 50000.0,
      clientId: 'cust_1',
      managerId: 'emp_1',
      completionPercentage: 35.0,
      tags: ['Mobile', 'UX', 'Flutter'],
    ),
    Project(
      id: 'proj_2',
      name: 'Website Migration',
      description: 'Moving the legacy website to a new cloud infrastructure.',
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().add(const Duration(days: 20)),
      status: ProjectStatus.inProgress,
      type: ProjectType.timeAndMaterial,
      priority: ProjectPriority.medium,
      budget: 15000.0,
      clientId: 'cust_2',
      managerId: 'emp_2',
      completionPercentage: 15.0,
      tags: ['Web', 'Cloud', 'Migration'],
    ),
    Project(
      id: 'proj_3',
      name: 'Q3 Marketing Campaign',
      description: 'Planning and executing the marketing strategy for Q3.',
      startDate: DateTime.now().add(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 90)),
      status: ProjectStatus.planned,
      type: ProjectType.fixedCost,
      priority: ProjectPriority.medium,
      budget: 25000.0,
      clientId: 'cust_3',
      managerId: 'emp_3',
      completionPercentage: 0.0,
      tags: ['Marketing', 'Ads'],
    ),
    Project(
      id: 'proj_4',
      name: 'Office Renovation',
      description: 'Renovating the main office reception and meeting rooms.',
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 45)),
      status: ProjectStatus.onHold,
      type: ProjectType.fixedCost,
      priority: ProjectPriority.low,
      budget: 12000.0,
      clientId: 'internal',
      managerId: 'emp_4',
      completionPercentage: 40.0,
      tags: ['Internal', 'Infrastructure'],
    ),
    Project(
      id: 'proj_5',
      name: 'ERP Implementation',
      description:
          'Full-scale implementation of the new ERP system for the client.',
      startDate: DateTime.now().subtract(const Duration(days: 60)),
      endDate: DateTime.now().add(const Duration(days: 120)),
      status: ProjectStatus.inProgress,
      type: ProjectType.timeAndMaterial,
      priority: ProjectPriority.high,
      budget: 150000.0,
      clientId: 'cust_5',
      managerId: 'emp_1',
      completionPercentage: 60.0,
      tags: ['Enterprise', 'Software', 'Big Data'],
    ),
  ];

  Future<List<Project>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_projects);
  }

  Future<Project?> getProjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addProject(Project project) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _projects.add(project);
  }

  Future<void> updateProject(Project project) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  Future<void> deleteProject(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _projects.removeWhere((p) => p.id == id);
  }
}
