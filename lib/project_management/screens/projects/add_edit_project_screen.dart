import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/project.dart';
import '../../services/projects_service.dart';
import '../../../crm/data/repositories/crm_repository_impl.dart';
import '../../../crm/data/datasources/crm_remote_datasource.dart';
import '../../../crm/models/customer.dart';

class AddEditProjectScreen extends StatefulWidget {
  final Project? project;

  const AddEditProjectScreen({super.key, this.project});

  @override
  State<AddEditProjectScreen> createState() => _AddEditProjectScreenState();
}

class _AddEditProjectScreenState extends State<AddEditProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _budgetController;

  DateTime? _startDate;
  DateTime? _endDate;
  ProjectStatus _status = ProjectStatus.planned;
  ProjectType _type = ProjectType.fixedCost;
  ProjectPriority _priority = ProjectPriority.medium;
  String? _selectedClientId;
  List<Customer> _customers = [];
  bool _isLoadingCustomers = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.project?.description ?? '',
    );
    _budgetController = TextEditingController(
      text: widget.project?.budget.toString() ?? '',
    );
    _startDate = widget.project?.startDate ?? DateTime.now();
    _endDate = widget.project?.endDate;
    _status = widget.project?.status ?? ProjectStatus.planned;
    _type = widget.project?.type ?? ProjectType.fixedCost;
    _priority = widget.project?.priority ?? ProjectPriority.medium;
    _selectedClientId = widget.project?.clientId;

    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    // Integration: Fetch real customers from CRM module
    final repo = CrmRepositoryImpl(remoteDataSource: CrmRemoteDataSourceImpl());
    final customers = await repo.getCustomers();
    if (mounted) {
      setState(() {
        _customers = customers;
        _isLoadingCustomers = false;
        // If we are editing and have a client ID, make sure it's valid, else null
        if (_selectedClientId != null &&
            !_customers.any((c) => c.id == _selectedClientId)) {
          // Handle case where linked customer might not exist in local mock list
          // For now, we accept it might be an 'external' id not in top 20 list,
          // but normally we would want to ensure it matches.
          // We will prepend a "Current Client" if missing to avoid dropdown error
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      final project = Project(
        id:
            widget.project?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _startDate!,
        endDate: _endDate,
        status: _status,
        type: _type,
        priority: _priority,
        budget: double.tryParse(_budgetController.text) ?? 0.0,
        clientId: _selectedClientId ?? 'internal',
        managerId: 'current_user', // Placeholder
        completionPercentage: widget.project?.completionPercentage ?? 0.0,
        tags: widget.project?.tags ?? [], // Preserve tags for now
      );

      if (widget.project == null) {
        await ProjectsService().addProject(project);
      } else {
        await ProjectsService().updateProject(project);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Project' : 'New Project',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: _saveProject,
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
              _buildSectionContainer(
                title: 'Project Info',
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Project Name',
                    icon: Icons.assignment,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionContainer(
                title: 'Planning',
                children: [
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
                          label: 'End Date',
                          selectedDate: _endDate,
                          onSelect: (date) => setState(() => _endDate = date),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown<ProjectType>(
                          value: _type,
                          label: 'Type',
                          items: ProjectType.values,
                          labelBuilder: (t) => t == ProjectType.fixedCost
                              ? 'Fixed Cost'
                              : 'Time & Material',
                          onChanged: (val) => setState(() => _type = val!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown<ProjectStatus>(
                          value: _status,
                          label: 'Status',
                          items: ProjectStatus.values,
                          labelBuilder: (s) => s.label,
                          onChanged: (val) => setState(() => _status = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown<ProjectPriority>(
                    value: _priority,
                    label: 'Priority',
                    items: ProjectPriority.values,
                    labelBuilder: (p) => p.label,
                    onChanged: (val) => setState(() => _priority = val!),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionContainer(
                title: 'Financials & Client',
                children: [
                  _buildTextField(
                    controller: _budgetController,
                    label: 'Estimated Budget',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue:
                        _selectedClientId != null &&
                            _customers.any((c) => c.id == _selectedClientId)
                        ? _selectedClientId
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Client',
                      prefixIcon: const Icon(
                        Icons.business,
                        color: Color(0xFF5B30BA),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF4F7FE),
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
                    items: [
                      const DropdownMenuItem(
                        value: 'internal',
                        child: Text('Internal Project'),
                      ),
                      ..._customers.map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.company),
                        ),
                      ),
                    ],
                    onChanged: (val) => setState(() => _selectedClientId = val),
                    hint: _isLoadingCustomers
                        ? const Text('Loading Clients...')
                        : const Text('Select Client'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFF1B2559),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFA3AED0)),
        prefixIcon: Icon(icon, color: const Color(0xFF5B30BA)),
        filled: true,
        fillColor: const Color(0xFFF4F7FE),
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
    required DateTime? selectedDate,
    required Function(DateTime) onSelect,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF4318FF),
                  onPrimary: Colors.white,
                  onSurface: Color(0xFF1B2559),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7FE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
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
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    selectedDate != null
                        ? DateFormat('dd MMM yyyy').format(selectedDate)
                        : 'Select Date',
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
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFA3AED0)),
        filled: true,
        fillColor: const Color(0xFFF4F7FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF5B30BA)),
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
