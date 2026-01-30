import 'package:flutter/material.dart';
import '../../models/warehouse.dart';
import '../../services/warehouse_service.dart';

class WarehousesScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const WarehousesScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  late Future<List<Warehouse>> _warehousesFuture;

  @override
  void initState() {
    super.initState();
    _warehousesFuture = WarehouseService().getWarehouses();
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
          'Warehouses',
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
        child: const Icon(Icons.add_business_rounded, color: Colors.white),
      ),
      body: FutureBuilder<List<Warehouse>>(
        future: _warehousesFuture,
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
            return const Center(child: Text('No warehouses found'));
          }

          final warehouses = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: warehouses.length,
            itemBuilder: (context, index) {
              final warehouse = warehouses[index];
              return _buildWarehouseCard(warehouse);
            },
          );
        },
      ),
    );
  }

  Widget _buildWarehouseCard(Warehouse warehouse) {
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
              Text(
                warehouse.id,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF6C00),
                ),
              ),
              const Icon(
                Icons.warehouse_rounded,
                color: Color(0xFFA3AED0),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            warehouse.name,
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
                Icons.location_on_outlined,
                size: 14,
                color: Color(0xFFA3AED0),
              ),
              const SizedBox(width: 4),
              Text(
                warehouse.location,
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Capacity: ${warehouse.capacity}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
              Text(
                '${warehouse.totalItems} Items',
                style: const TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: warehouse.capacity / 100,
            backgroundColor: const Color(0xFFF4F7FE),
            color: warehouse.capacity > 80
                ? Colors.red
                : const Color(0xFFEF6C00),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 14,
                color: Color(0xFFA3AED0),
              ),
              const SizedBox(width: 4),
              Text(
                'Manager: ${warehouse.manager}',
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
