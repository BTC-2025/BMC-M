import 'package:flutter/material.dart';
import '../../models/customer.dart';

import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';

class AddEditCustomerScreen extends StatefulWidget {
  final Customer? customer;

  const AddEditCustomerScreen({super.key, this.customer});

  @override
  State<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends State<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _company;
  late String _email;
  late String _phone;
  late String _address;
  late CustomerStatus _status;

  @override
  void initState() {
    super.initState();
    final c = widget.customer;
    _name = c?.name ?? '';
    _company = c?.company ?? '';
    _email = c?.email ?? '';
    _phone = c?.phone ?? '';
    _address = c?.address ?? '';
    _status = c?.status ?? CustomerStatus.active;
  }

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newCustomer = Customer(
        id:
            widget.customer?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
        company: _company,
        email: _email,
        phone: _phone,
        status: _status,
        joinDate: widget.customer?.joinDate ?? DateTime.now(),
        totalRevenue: widget.customer?.totalRevenue ?? 0.0,
        address: _address,
        accountManagerId: widget.customer?.accountManagerId ?? 'user_1',
      );

      final repo = CrmRepositoryImpl(
        remoteDataSource: CrmRemoteDataSourceImpl(),
      );
      if (widget.customer != null) {
        await repo.updateCustomer(newCustomer);
      } else {
        await repo.addCustomer(newCustomer);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.customer != null ? 'Edit Customer' : 'Add New Customer',
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
              _buildSectionTitle('Basic Info'),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Name',
                initialValue: _name,
                onSaved: (v) => _name = v!,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Company',
                initialValue: _company,
                onSaved: (v) => _company = v!,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Contact'),
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
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Address',
                initialValue: _address,
                onSaved: (v) => _address = v!,
                maxLines: 2,
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Status'),
              const SizedBox(height: 16),
              DropdownButtonFormField<CustomerStatus>(
                initialValue: _status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  filled: true,
                  fillColor: const Color(0xFFF4F7FE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: CustomerStatus.values.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s.label));
                }).toList(),
                onChanged: (s) => setState(() => _status = s!),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveCustomer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4318FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    widget.customer != null
                        ? 'Update Customer'
                        : 'Create Customer',
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
}
