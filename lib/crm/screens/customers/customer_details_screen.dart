import 'package:flutter/material.dart';
import '../../models/customer.dart';

import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';
import 'add_edit_customer_screen.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen>
    with SingleTickerProviderStateMixin {
  late Future<Customer?> _customerFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final repo = CrmRepositoryImpl(remoteDataSource: CrmRemoteDataSourceImpl());
    _customerFuture = repo.getCustomerById(widget.customerId);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Customer Profile',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final customer = await _customerFuture;
              if (customer != null && context.mounted) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditCustomerScreen(customer: customer),
                  ),
                );
                if (result == true) {
                  setState(() {
                    final repo = CrmRepositoryImpl(
                      remoteDataSource: CrmRemoteDataSourceImpl(),
                    );
                    _customerFuture = repo.getCustomerById(widget.customerId);
                  });
                }
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<Customer?>(
        future: _customerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Customer not found'));
          }

          final customer = snapshot.data!;
          return Column(
            children: [
              _buildHeader(customer),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(customer),
                    _buildOrdersTab(),
                    _buildTicketsTab(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(Customer customer) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF4318FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                customer.initials,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4318FF),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customer.company,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA3AED0),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: customer.status.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    customer.status.label,
                    style: TextStyle(
                      color: customer.status.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF4318FF),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFFA3AED0),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: "Overview"),
          Tab(text: "Orders"),
          Tab(text: "Tickets"),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Customer customer) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _buildInfoCard("Contact Info", [
          _buildInfoRow('Email', customer.email),
          _buildInfoRow('Phone', customer.phone),
          _buildInfoRow('Address', customer.address),
        ]),
        const SizedBox(height: 20),
        _buildInfoCard("Financials", [
          _buildInfoRow(
            'Total Spend (LTV)',
            '\$${customer.totalRevenue.toStringAsFixed(2)}',
          ),
          _buildInfoRow(
            'Join Date',
            customer.joinDate.toString().split(' ')[0],
          ),
        ]),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1B2559),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#ORD-2024-${1000 + index}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Nov 24, 2024",
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF05CD99).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Completed",
                  style: TextStyle(
                    color: Color(0xFF05CD99),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "\$1,240.00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTicketsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Login Issue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB547).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "In Progress",
                      style: TextStyle(
                        color: Color(0xFFFFB547),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Customer unable to login to the dashboard portal...",
                style: TextStyle(color: Color(0xFF707EAE), fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}
