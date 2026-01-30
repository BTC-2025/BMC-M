import '../../models/customer.dart';
import '../../models/lead.dart';

import '../../../../infrastructure/error_reporting/error_reporter.dart';

abstract class CrmRemoteDataSource {
  Future<List<Lead>> fetchLeads();
  Future<List<Customer>> fetchCustomers();
  Future<void> addLead(Lead lead);
  Future<void> addCustomer(Customer customer);
  // Add other methods as needed
}

class CrmRemoteDataSourceImpl implements CrmRemoteDataSource {
  // Mock Data (Moved from Legacy Services)
  final List<Lead> _leads = List.generate(
    15,
    (index) => Lead(
      id: 'lead_${index + 1}',
      firstName: ['John', 'Jane', 'Robert', 'Emily', 'Michael'][index % 5],
      lastName: ['Doe', 'Smith', 'Johnson', 'Williams', 'Brown'][index % 5],
      company: [
        'Tech Corp',
        'Innovate LLC',
        'Global Inc',
        'StartUp Sys',
        'Enterprise Sol',
      ][index % 5],
      email: 'lead${index + 1}@example.com',
      phone: '+1 555 010 ${100 + index}',
      value: (index + 1) * 2500.0,
      status: LeadStatus.values[index % LeadStatus.values.length],
      source: ['Website', 'LinkedIn', 'Referral', 'Cold Call'][index % 4],
      createdAt: DateTime.now().subtract(Duration(days: index * 2)),
      lastContacted: DateTime.now().subtract(Duration(days: index)),
      ownerId: 'user_1',
      tags: index % 2 == 0 ? ['Key Account', 'Urgent'] : ['Follow-up'],
      notes: 'This is a sample note for lead ${index + 1}.',
      activities: [],
      notesList: [],
    ),
  );

  final List<Customer> _customers = List.generate(
    20,
    (index) => Customer(
      id: 'cust_${index + 1}',
      name: ['Alice', 'Bob', 'Charlie', 'Diana', 'Evan'][index % 5],
      company: [
        'MegaCorp',
        'TechFlow',
        'SoftServe',
        'DataDyne',
        'Cyberdyne',
      ][index % 5],
      email: 'customer${index + 1}@example.com',
      phone: '+1 555 020 ${100 + index}',
      status: CustomerStatus.values[index % CustomerStatus.values.length],
      joinDate: DateTime.now().subtract(Duration(days: index * 10)),
      totalRevenue: (index + 1) * 1500.0 + 500.0,
      address: '123 Market St',
      accountManagerId: 'user_1',
      tags: [],
    ),
  );

  @override
  Future<List<Lead>> fetchLeads() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return List.from(_leads);
    } catch (e, s) {
      ErrorReporter.report(e, s, context: 'CrmRemoteDataSource.fetchLeads');
      rethrow;
    }
  }

  @override
  Future<List<Customer>> fetchCustomers() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return List.from(_customers);
    } catch (e, s) {
      ErrorReporter.report(e, s, context: 'CrmRemoteDataSource.fetchCustomers');
      rethrow;
    }
  }

  @override
  Future<void> addLead(Lead lead) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _leads.add(lead);
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _customers.add(customer);
  }
}
