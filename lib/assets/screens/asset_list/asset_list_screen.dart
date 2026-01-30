import 'package:flutter/material.dart';

class AssetListScreen extends StatelessWidget {
  const AssetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Asset Inventory',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4318FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSearchField(),
          const SizedBox(height: 20),
          _buildAssetCard(
            'MacBook Pro M2',
            'IT Department',
            'AST-2024-001',
            'In Use',
            Colors.green,
            Icons.laptop_mac,
          ),
          _buildAssetCard(
            'Industrial CNC Cutter',
            'Manufacturing',
            'AST-2023-042',
            'Maintenance',
            Colors.orange,
            Icons.precision_manufacturing,
          ),
          _buildAssetCard(
            'Delivery Truck A',
            'Logistics',
            'AST-2023-019',
            'In Use',
            Colors.green,
            Icons.local_shipping,
          ),
          _buildAssetCard(
            'Office Printer HP',
            'Admin',
            'AST-2022-103',
            'Repaired',
            Colors.blue,
            Icons.print,
          ),
          _buildAssetCard(
            'Server Rack Dell',
            'IT Infrastructure',
            'AST-2024-005',
            'In Use',
            Colors.green,
            Icons.dns,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search assets...',
          hintStyle: const TextStyle(color: Color(0xFFA3AED0)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF4318FF)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildAssetCard(
    String name,
    String dept,
    String id,
    String status,
    Color statusColor,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF4318FF), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$dept • $id',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
