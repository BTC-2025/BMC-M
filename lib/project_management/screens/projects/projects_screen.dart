import 'package:flutter/material.dart';
import '../../../crm/widgets/crm_header.dart';
import '../../models/project.dart';
import '../../services/projects_service.dart';
import 'project_details_screen.dart';
import 'add_edit_project_screen.dart';

class ProjectsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectsScreen({super.key, this.onBack, this.onMenu});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late Future<List<Project>> _projectsFuture;
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _refreshProjects();
  }

  void _refreshProjects() {
    setState(() {
      _projectsFuture = ProjectsService().getProjects();
    });
  }

  Future<void> _navigateToAddProject() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditProjectScreen()),
    );
    if (result == true) {
      _refreshProjects();
    }
  }

  Future<void> _navigateToProjectDetails(Project project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailsScreen(projectId: project.id),
      ),
    );
    _refreshProjects(); // Refresh in case edits happened in details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProject,
        backgroundColor: const Color(0xFF5B30BA),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              // Reusing CRM Header for consistency, or we could make a shared one.
              // For now assuming CrmHeader is generic enough visually.
              child: CrmHeader(
                title: 'Projects',
                subtitle: 'Track Scope, Time & Budgets',
                onBack: widget.onBack,
                onMenu: widget.onMenu,
              ),
            ),
            _buildSearchAndFilter(),
            Expanded(child: _buildProjectsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search projects...',
              hintStyle: const TextStyle(
                color: Color(0xFFA3AED0),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF5B30BA),
                size: 20,
              ),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildPillFilter('All', _statusFilter == 'All'),
              ...ProjectStatus.values.map(
                (s) => _buildPillFilter(s.label, _statusFilter == s.label),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPillFilter(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _statusFilter = label),
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF5B30BA),
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFFA3AED0),
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFF5B30BA)
                : const Color(0xFFE0E5F2),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsList() {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No projects found'));
        }

        var projects = snapshot.data!;

        // Filtering
        if (_searchQuery.isNotEmpty) {
          final q = _searchQuery.toLowerCase();
          projects = projects
              .where((p) => p.name.toLowerCase().contains(q))
              .toList();
        }
        if (_statusFilter != 'All') {
          projects = projects
              .where((p) => p.status.label == _statusFilter)
              .toList();
        }

        if (projects.isEmpty) {
          return const Center(child: Text('No matching projects'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            _refreshProjects();
            await _projectsFuture;
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => _navigateToProjectDetails(projects[index]),
                  child: _buildProjectCard(projects[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(Project project) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: project.status.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  project.status.label,
                  style: TextStyle(
                    color: project.status.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            project.description,
            style: const TextStyle(fontSize: 13, color: Color(0xFFA3AED0)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildIconText(
                Icons.calendar_today_rounded,
                _formatDate(project.startDate),
              ),
              const SizedBox(width: 16),
              _buildIconText(
                Icons.attach_money_rounded,
                '\$${project.budget.toStringAsFixed(0)}',
              ),
              const Spacer(),
              _buildIconText(
                Icons.flag_rounded,
                project.priority.label,
                color: project.priority.color,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
                  ),
                  Text(
                    '${project.completionPercentage.toInt()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: project.completionPercentage / 100,
                  backgroundColor: const Color(0xFFF4F7FE),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    project.completionPercentage >= 100
                        ? Colors.green
                        : const Color(0xFF5B30BA),
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? const Color(0xFFA3AED0)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color ?? const Color(0xFF707EAE),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
