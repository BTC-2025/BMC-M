import '../models/project_member.dart';

class ProjectTeamService {
  static final ProjectTeamService _instance = ProjectTeamService._internal();

  factory ProjectTeamService() {
    return _instance;
  }

  ProjectTeamService._internal();

  // Mock Data
  final List<ProjectMember> _members = [
    // Team for Mobile App Redesign (proj_1)
    ProjectMember(
      id: 'mem_1',
      projectId: 'proj_1',
      userId: 'emp_1',
      userName: 'John Doe',
      role: ProjectRole.manager,
      joinedAt: DateTime.now().subtract(const Duration(days: 30)),
      utilizationPercentage: 50.0,
    ),
    ProjectMember(
      id: 'mem_2',
      projectId: 'proj_1',
      userId: 'emp_2',
      userName: 'Jane Smith',
      role: ProjectRole.designer,
      joinedAt: DateTime.now().subtract(const Duration(days: 28)),
      utilizationPercentage: 100.0,
    ),
    ProjectMember(
      id: 'mem_3',
      projectId: 'proj_1',
      userId: 'emp_3',
      userName: 'Mike Johnson',
      role: ProjectRole.developer,
      joinedAt: DateTime.now().subtract(const Duration(days: 25)),
      utilizationPercentage: 80.0,
    ),

    // Team for Website Migration (proj_2)
    ProjectMember(
      id: 'mem_4',
      projectId: 'proj_2',
      userId: 'emp_2', // Jane is also here
      userName: 'Jane Smith',
      role: ProjectRole.manager,
      joinedAt: DateTime.now().subtract(const Duration(days: 10)),
      utilizationPercentage: 50.0, // Split time
    ),
    ProjectMember(
      id: 'mem_5',
      projectId: 'proj_2',
      userId: 'emp_4',
      userName: 'Sarah Williams',
      role: ProjectRole.developer,
      joinedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  Future<List<ProjectMember>> getTeamMembers(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _members.where((m) => m.projectId == projectId).toList();
  }

  Future<void> addMember(ProjectMember member) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _members.add(member);
  }

  Future<void> removeMember(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _members.removeWhere((m) => m.id == memberId);
  }
}
