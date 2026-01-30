import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';
import '../../services/tasks_service.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String projectId;
  final ProjectTask? task;

  const AddEditTaskScreen({super.key, required this.projectId, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late DateTime _startDate;
  late DateTime _dueDate;
  late TaskStatus _status;
  late TaskPriority _priority;
  String? _assignedTo;

  // Mock Employees List
  final List<Map<String, String>> _employees = [
    {'id': 'emp_1', 'name': 'John Doe'},
    {'id': 'emp_2', 'name': 'Jane Smith'},
    {'id': 'emp_3', 'name': 'Mike Johnson'},
    {'id': 'emp_4', 'name': 'Sarah Williams'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _startDate = widget.task?.startDate ?? DateTime.now();
    _dueDate =
        widget.task?.dueDate ?? DateTime.now().add(const Duration(days: 7));
    _status = widget.task?.status ?? TaskStatus.todo;
    _priority = widget.task?.priority ?? TaskPriority.medium;
    _assignedTo = widget.task?.assignedTo;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final task = ProjectTask(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        projectId: widget.projectId,
        title: _titleController.text,
        description: _descriptionController.text,
        status: _status,
        priority: _priority,
        assignedTo: _assignedTo,
        startDate: _startDate,
        dueDate: _dueDate,
        tags: widget.task?.tags ?? [],
      );

      if (widget.task == null) {
        await TasksService().addTask(task);
      } else {
        await TasksService().updateTask(task);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Task' : 'New Task',
          style: const TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
        actions: [
          TextButton(
            onPressed: _saveTask,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Task Details'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _titleController,
                label: 'Task Title',
                icon: Icons.title,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Schedule'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Start Date',
                      selectedDate: _startDate,
                      onSelect: (date) => setState(() => _startDate = date),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Due Date',
                      selectedDate: _dueDate,
                      onSelect: (date) => setState(() => _dueDate = date),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Status & Assignment'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown<TaskStatus>(
                      value: _status,
                      label: 'Status',
                      items: TaskStatus.values,
                      labelBuilder: (s) => s.label,
                      onChanged: (val) => setState(() => _status = val!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown<TaskPriority>(
                      value: _priority,
                      label: 'Priority',
                      items: TaskPriority.values,
                      labelBuilder: (p) => p.label,
                      onChanged: (val) => setState(() => _priority = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _assignedTo,
                decoration: InputDecoration(
                  labelText: 'Assigned To',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF5B30BA),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownColor: Colors.white,
                items: _employees.map((e) {
                  return DropdownMenuItem(
                    value: e['id'],
                    child: Text(e['name']!),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _assignedTo = val),
                hint: const Text('Unassigned'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF5B30BA)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF5B30BA), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime selectedDate,
    required Function(DateTime) onSelect,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xFF5B30BA),
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('dd MMM yyyy').format(selectedDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required String label,
    required List<T> items,
    required String Function(T) labelBuilder,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(labelBuilder(item)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
