import 'package:flutter/material.dart';
import '../../models/supplier.dart';
import '../../services/suppliers_service.dart';

class SuppliersScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const SuppliersScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  late Future<List<Supplier>> _suppliersFuture;

  @override
  void initState() {
    super.initState();
    _suppliersFuture = SuppliersService().getSuppliers();
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
            color: Color(0xFFEF6C00),
            size: 20,
          ),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Suppliers',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFFEF6C00)),
            onPressed: widget.onMenu,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFEF6C00),
        child: const Icon(Icons.person_add_rounded, color: Colors.white),
      ),
      body: FutureBuilder<List<Supplier>>(
        future: _suppliersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFEF6C00)),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No suppliers found'));
          }

          final suppliers = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return _buildSupplierCard(supplier);
            },
          );
        },
      ),
    );
  }

  Widget _buildSupplierCard(Supplier supplier) {
    Color statusColor;
    switch (supplier.status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Suspended':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  supplier.category,
                  style: const TextStyle(
                    color: Color(0xFFEF6C00),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  supplier.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            supplier.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 14,
                color: Color(0xFFA3AED0),
              ),
              const SizedBox(width: 4),
              Text(
                supplier.contactPerson,
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    supplier.email,
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    supplier.phone,
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.orange,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    supplier.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
