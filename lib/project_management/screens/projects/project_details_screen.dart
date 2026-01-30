import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/project.dart';
import '../../models/task.dart';
import '../../services/projects_service.dart';
import '../../services/tasks_service.dart';
import '../../models/project_member.dart';
import '../../services/project_team_service.dart';
import '../../models/expense.dart';
import '../../services/project_finance_service.dart';
import 'add_edit_project_screen.dart';
import '../tasks/add_edit_task_screen.dart'; // Import this

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late Future<Project?> _projectFuture;
  late Future<List<ProjectTask>> _tasksFuture;
  late Future<List<ProjectMember>> _membersFuture;
  late Future<List<ProjectExpense>> _expensesFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _refreshProject();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _refreshProject() {
    setState(() {
      _projectFuture = ProjectsService().getProjectById(widget.projectId);
      _tasksFuture = TasksService().getTasksByProjectId(widget.projectId);
      _membersFuture = ProjectTeamService().getTeamMembers(widget.projectId);
      _expensesFuture = ProjectFinanceService().getExpensesByProject(
        widget.projectId,
      );
    });
  }

  Future<void> _navigateToAddEditTask(
    String projectId, {
    ProjectTask? task,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditTaskScreen(projectId: projectId, task: task),
      ),
    );
    if (result == true) {
      _refreshProject();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: FutureBuilder<Project?>(
        future: _projectFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Project not found'));
          }

          final project = snapshot.data!;
          return Column(
            children: [
              _buildPremiumHeader(project),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelColor: const Color(0xFF4318FF),
                            unselectedLabelColor: const Color(0xFFA3AED0),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            indicatorColor: const Color(0xFF4318FF),
                            indicatorWeight: 4,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: const [
                              Tab(text: 'Overview'),
                              Tab(text: 'Tasks'),
                              Tab(text: 'Team'),
                              Tab(text: 'Budget'),
                            ],
                          ),
                          const Divider(height: 1, color: Color(0xFFE0E5F2)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildOverviewTab(project),
                          _buildTasksTab(project),
                          _buildTeamTab(project),
                          _buildFinancialsTab(project),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPremiumHeader(Project project) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000), // Very subtle shadow
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF1B2559),
                      size: 18,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Project Details',
                    style: TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF1B2559),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddEditProjectScreen(project: project),
                        ),
                      );
                      if (result == true) {
                        _refreshProject();
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4318FF).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: CircularProgressIndicator(
                            value: project.completionPercentage / 100,
                            backgroundColor: Colors.white24,
                            color: const Color(0xFF05CD99), // Success Green
                            strokeWidth: 6,
                          ),
                        ),
                        Text(
                          '${project.completionPercentage.toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  project.status.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  project.priority.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(Project project) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Description'),
        const SizedBox(height: 8),
        Text(
          project.description,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF4A5568),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoCard([
          _buildInfoRow(
            'Start Date',
            DateFormat('dd MMM yyyy').format(project.startDate),
          ),
          if (project.endDate != null)
            _buildInfoRow(
              'Due Date',
              DateFormat('dd MMM yyyy').format(project.endDate!),
            ),
          _buildInfoRow(
            'Priority',
            project.priority.label,
            valueColor: project.priority.color,
          ),
          _buildInfoRow(
            'Project Type',
            project.type == ProjectType.fixedCost
                ? 'Fixed Cost'
                : 'Time & Material',
          ),
          _buildInfoRow(
            'Budget',
            NumberFormat.currency(symbol: '\$').format(project.budget),
          ),
        ]),
        const SizedBox(height: 24),
        _buildSectionTitle('Tags'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.tags
              .map(
                (tag) => Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF5B30BA),
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: const Color(0xFFF4F7FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTasksTab(Project project) {
    return FutureBuilder<List<ProjectTask>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.playlist_add_check_rounded,
                  size: 48,
                  color: Color(0xFFA3AED0),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No tasks added yet',
                  style: TextStyle(color: Color(0xFFA3AED0)),
                ),
                TextButton.icon(
                  onPressed: () {
                    _navigateToAddEditTask(project.id);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Task'),
                ),
              ],
            ),
          );
        }

        final tasks = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: tasks.length + 1, // +1 for Add Button
          itemBuilder: (context, index) {
            if (index == tasks.length) {
              return TextButton.icon(
                onPressed: () {
                  _navigateToAddEditTask(project.id);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Task'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
            final task = tasks[index];
            return GestureDetector(
              onTap: () => _navigateToAddEditTask(project.id, task: task),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(color: task.priority.color, width: 4),
                  ),
                  /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                */
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1B2559),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: task.status.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            task.status.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: task.status.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('MMM dd').format(task.dueDate),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Spacer(),
                        if (task.assignedTo != null)
                          const CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xFF5B30BA),
                            child: Text(
                              'JS',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ), // Mock Initials
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTeamTab(Project project) {
    return FutureBuilder<List<ProjectMember>>(
      future: _membersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.groups_rounded,
                  size: 48,
                  color: Color(0xFFA3AED0),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No team members assigned',
                  style: TextStyle(color: Color(0xFFA3AED0)),
                ),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add Member feature coming soon!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1_rounded),
                  label: const Text('Add Member'),
                ),
              ],
            ),
          );
        }

        final members = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: members.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final member = members[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                */
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF5B30BA),
                    child: Text(
                      member.userName
                          .split(' ')
                          .map((e) => e[0])
                          .take(2)
                          .join('')
                          .toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ), // Initials
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1B2559),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Joined ${DateFormat('MMM yyyy').format(member.joinedAt)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFFA3AED0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: member.role.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      member.role.label,
                      style: TextStyle(
                        color: member.role.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFinancialsTab(Project project) {
    return FutureBuilder<List<ProjectExpense>>(
      future: _expensesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final expenses = snapshot.data ?? [];
        // Calculate Total Cost (Expenses + Mock Labor)
        // In a real app we'd sum (TimeEntry.hours * Rate)
        double totalExpenses = expenses.fold(0, (sum, e) => sum + e.amount);
        double estimatedLabor =
            project.budget * 0.3; // Mock labor burn based on budget for viz
        double totalSpent = totalExpenses + estimatedLabor;
        double remaining = project.budget - totalSpent;
        double progress = (totalSpent / project.budget).clamp(0.0, 1.0);

        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildSectionTitle('Budget Overview'),
            const SizedBox(height: 16),
            _buildInfoCard([
              _buildInfoRow(
                'Total Budget',
                NumberFormat.currency(symbol: '\$').format(project.budget),
              ),
              _buildInfoRow(
                'Total Spent',
                NumberFormat.currency(symbol: '\$').format(totalSpent),
              ),
              _buildInfoRow(
                'Remaining',
                NumberFormat.currency(symbol: '\$').format(remaining),
                valueColor: remaining < 0 ? Colors.red : Colors.green,
              ),
            ]),
            const SizedBox(height: 24),
            Text(
              'Budget Utilization (${(progress * 100).toInt()}%)',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF4F7FE),
              color: progress > 0.9 ? Colors.red : const Color(0xFF5B30BA),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('Expenses'),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add Expense feature coming soon!'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Color(0xFF5B30BA),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (expenses.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No expenses recorded',
                    style: TextStyle(color: Color(0xFFA3AED0)),
                  ),
                ),
              )
            else
              ...expenses.map(
                (e) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(color: Colors.grey[300]!, width: 4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B2559),
                            ),
                          ),
                          Text(
                            DateFormat('MMM dd, yyyy').format(e.date),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA3AED0),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(symbol: '\$').format(e.amount),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF1B2559),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children
            .map(
              (w) =>
                  Padding(padding: const EdgeInsets.only(bottom: 12), child: w),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? const Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
