import '../../models/customer.dart';
import '../../models/lead.dart';

abstract class CrmRepository {
  // Leads
  Future<List<Lead>> getLeads();
  Future<Lead?> getLeadById(String id);
  Future<void> addLead(Lead lead);
  Future<void> updateLead(Lead lead);
  Future<void> deleteLead(String id);

  // Customers
  Future<List<Customer>> getCustomers();
  Future<Customer?> getCustomerById(String id);
  Future<void> addCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
}
