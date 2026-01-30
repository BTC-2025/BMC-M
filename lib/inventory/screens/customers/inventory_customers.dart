import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryCustomers extends StatelessWidget {
  const InventoryCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: InventoryHeader(
                title: 'Customers',
                subtitle: 'Client Relationship Management',
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildCustomerTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerTile(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFE0E5F2),
            child: Text(
              'C${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enterprise Client #${index + 100}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Active since Jan 2025',
                  style: TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(index + 1) * 1500}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const Text(
                'LTV',
                style: TextStyle(fontSize: 10, color: Color(0xFFA3AED0)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
