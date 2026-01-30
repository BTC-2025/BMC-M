import 'package:flutter/material.dart';
import '../../widgets/crm_header.dart';
import '../../models/customer.dart';
import '../../domain/repositories/crm_repository.dart';
import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';
import 'customer_details_screen.dart';
import 'add_edit_customer_screen.dart';

class CustomersScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const CustomersScreen({super.key, this.onBack, this.onMenu});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late final CrmRepository _crmRepository;
  late Future<List<Customer>> _customersFuture;
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _crmRepository = CrmRepositoryImpl(
      remoteDataSource: CrmRemoteDataSourceImpl(),
    );
    _refreshCustomers();
  }

  void _refreshCustomers() {
    setState(() {
      _customersFuture = _crmRepository.getCustomers();
    });
  }

  Future<void> _navigateToAddCustomer() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEditCustomerScreen()),
    );
    if (result == true) {
      _refreshCustomers();
    }
  }

  Future<void> _navigateToCustomerDetails(Customer customer) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailsScreen(customerId: customer.id),
      ),
    );
    _refreshCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddCustomer,
        backgroundColor: const Color(0xFF2E3192),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: CrmHeader(
                title: 'Customers',
                subtitle: 'Active Clients & Accounts',
                onBack: widget.onBack,
                onMenu: widget.onMenu,
              ),
            ),
            _buildSearchAndFilter(),
            Expanded(child: _buildCustomersList()),
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
              hintText: 'Search companies, names...',
              hintStyle: const TextStyle(
                color: Color(0xFFA3AED0),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF4A55A2),
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
              ...CustomerStatus.values.map(
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
        selectedColor: const Color(0xFF2E3192),
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
                ? const Color(0xFF2E3192)
                : const Color(0xFFE0E5F2),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomersList() {
    return FutureBuilder<List<Customer>>(
      future: _customersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No customers found'));
        }

        var customers = snapshot.data!;
        if (_searchQuery.isNotEmpty) {
          final q = _searchQuery.toLowerCase();
          customers = customers
              .where(
                (c) =>
                    c.name.toLowerCase().contains(q) ||
                    c.company.toLowerCase().contains(q),
              )
              .toList();
        }
        if (_statusFilter != 'All') {
          customers = customers
              .where((c) => c.status.label == _statusFilter)
              .toList();
        }

        if (customers.isEmpty) {
          return const Center(child: Text('No matching customers'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            _refreshCustomers();
            await _customersFuture;
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildListHeader('COMPANY / NAME'),
                        ),
                        Expanded(flex: 3, child: _buildListHeader('STATUS')),
                        Expanded(flex: 2, child: _buildListHeader('LTV')),
                        const SizedBox(width: 32),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildListItem(context, customers[index]),
                    );
                  }, childCount: customers.length),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Color(0xFFA3AED0),
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Customer customer) {
    return GestureDetector(
      onTap: () => _navigateToCustomerDetails(customer),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: customer.status.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        customer.initials,
                        style: TextStyle(
                          color: customer.status.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.company,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          customer.name,
                          style: const TextStyle(
                            color: Color(0xFFA3AED0),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: customer.status.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  customer.status.label,
                  style: TextStyle(
                    color: customer.status.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '\$${customer.totalRevenue.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B3674),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB0BBD5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
