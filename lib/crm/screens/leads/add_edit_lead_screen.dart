import 'package:flutter/material.dart';
import '../../models/lead.dart';

import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';

class AddEditLeadScreen extends StatefulWidget {
  final Lead? lead;

  const AddEditLeadScreen({super.key, this.lead});

  @override
  State<AddEditLeadScreen> createState() => _AddEditLeadScreenState();
}

class _AddEditLeadScreenState extends State<AddEditLeadScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _lastName;
  late String _company;
  late String _email;
  late String _phone;
  late double _value;
  late LeadStatus _status;
  late String _source;
  late String _notes;

  @override
  void initState() {
    super.initState();
    final l = widget.lead;
    _firstName = l?.firstName ?? '';
    _lastName = l?.lastName ?? '';
    _company = l?.company ?? '';
    _email = l?.email ?? '';
    _phone = l?.phone ?? '';
    _value = l?.value ?? 0.0;
    _status = l?.status ?? LeadStatus.newLead;
    _source = l?.source ?? 'Website';
    _notes = l?.notes ?? '';
  }

  Future<void> _saveLead() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newLead = Lead(
        id: widget.lead?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: _firstName,
        lastName: _lastName,
        company: _company,
        email: _email,
        phone: _phone,
        value: _value,
        status: _status,
        source: _source,
        createdAt: widget.lead?.createdAt ?? DateTime.now(),
        lastContacted: widget.lead?.lastContacted ?? DateTime.now(),
        ownerId: widget.lead?.ownerId ?? 'current_user',
        notes: _notes,
      );

      final repo = CrmRepositoryImpl(
        remoteDataSource: CrmRemoteDataSourceImpl(),
      );
      if (widget.lead != null) {
        await repo.updateLead(newLead);
      } else {
        await repo.addLead(newLead);
      }

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate refresh
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.lead != null ? 'Edit Lead' : 'Add New Lead',
          style: const TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Basic Information'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'First Name',
                      initialValue: _firstName,
                      onSaved: (v) => _firstName = v!,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Last Name',
                      initialValue: _lastName,
                      onSaved: (v) => _lastName = v!,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Company',
                initialValue: _company,
                onSaved: (v) => _company = v!,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Contact Details'),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Email',
                initialValue: _email,
                onSaved: (v) => _email = v!,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Phone',
                initialValue: _phone,
                onSaved: (v) => _phone = v!,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Deal Information'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Estimated Value (\$)',
                      initialValue: _value > 0 ? _value.toString() : '',
                      onSaved: (v) => _value = double.tryParse(v!) ?? 0.0,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDropdown<LeadStatus>(
                label: 'Status',
                value: _status,
                items: LeadStatus.values,
                displayItem: (s) => s.label,
                onChanged: (s) => setState(() => _status = s!),
              ),
              const SizedBox(height: 16),
              _buildDropdown<String>(
                label: 'Source',
                value: _source,
                items: [
                  'Website',
                  'Referral',
                  'Cold Call',
                  'LinkedIn',
                  'Other',
                ],
                displayItem: (s) => s,
                onChanged: (s) => setState(() => _source = s!),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Notes'),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Additional Notes',
                initialValue: _notes,
                onSaved: (v) => _notes = v!,
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveLead,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4318FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    widget.lead != null ? 'Update Lead' : 'Create Lead',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
    required String label,
    required String initialValue,
    required Function(String?) onSaved,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFA3AED0)),
        filled: true,
        fillColor: const Color(0xFFF4F7FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF1B2559),
        fontWeight: FontWeight.w500,
      ),
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) displayItem,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFA3AED0)),
        filled: true,
        fillColor: const Color(0xFFF4F7FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            displayItem(item),
            style: const TextStyle(
              color: Color(0xFF1B2559),
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
    );
  }
}
