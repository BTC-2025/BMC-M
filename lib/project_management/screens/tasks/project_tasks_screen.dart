import 'package:flutter/material.dart';
import '../../services/tasks_service.dart';
import '../../models/task.dart';
import 'add_edit_task_screen.dart';

class ProjectTasksScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectTasksScreen({super.key, this.onBack, this.onMenu});

  @override
  State<ProjectTasksScreen> createState() => _ProjectTasksScreenState();
}

class _ProjectTasksScreenState extends State<ProjectTasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<ProjectTask>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasksFuture = TasksService().getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: widget.onBack ?? () => Navigator.pop(context),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.onMenu != null)
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
              onPressed: widget.onMenu,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4318FF),
          unselectedLabelColor: const Color(0xFFA3AED0),
          indicatorColor: const Color(0xFF4318FF),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'My Tasks'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditTaskScreen(projectId: 'all'),
            ),
          ).then((_) => _loadTasks());
        },
        backgroundColor: const Color(0xFF4318FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<ProjectTask>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          final allTasks = snapshot.data!;
          final myTasks = allTasks.where((t) => true).toList(); // Mock filter
          final completedTasks = allTasks
              .where((t) => t.status == TaskStatus.done)
              .toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildTaskList(allTasks),
              _buildTaskList(myTasks),
              _buildTaskList(completedTasks),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskList(List<ProjectTask> tasks) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFE9E3FF),
              child: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF4318FF),
              ),
            ),
            title: Text(
              task.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            subtitle: Text(
              'Due: ${task.dueDate.toString().split(' ')[0]}',
              style: const TextStyle(color: Color(0xFFA3AED0)),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: task.priority == TaskPriority.high
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                task.priority.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: task.priority == TaskPriority.high
                      ? Colors.red
                      : Colors.blue,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
