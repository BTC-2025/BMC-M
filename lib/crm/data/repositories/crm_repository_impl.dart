import '../../domain/repositories/crm_repository.dart';
import '../../models/customer.dart';
import '../../models/lead.dart';
import '../datasources/crm_remote_datasource.dart';

class CrmRepositoryImpl implements CrmRepository {
  final CrmRemoteDataSource remoteDataSource;

  CrmRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Lead>> getLeads() async {
    return await remoteDataSource.fetchLeads();
  }

  @override
  Future<Lead?> getLeadById(String id) async {
    final leads = await remoteDataSource.fetchLeads();
    try {
      return leads.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addLead(Lead lead) async {
    await remoteDataSource.addLead(lead);
  }

  @override
  Future<void> updateLead(Lead lead) async {
    // Implement update logic in datasource if needed
  }

  @override
  Future<void> deleteLead(String id) async {
    // Implement delete logic in datasource if needed
  }

  @override
  Future<List<Customer>> getCustomers() async {
    return await remoteDataSource.fetchCustomers();
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    final customers = await remoteDataSource.fetchCustomers();
    try {
      return customers.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    await remoteDataSource.addCustomer(customer);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    // Implement update logic
  }
}
