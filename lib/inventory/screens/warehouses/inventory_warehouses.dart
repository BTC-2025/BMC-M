import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryWarehouses extends StatelessWidget {
  const InventoryWarehouses({super.key});

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
                title: 'Warehouses',
                subtitle: 'Storage Locations',
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Full width cards
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildWarehouseCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.warehouse_rounded,
              color: Color(0xFF2196F3),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Warehouse Zone ${String.fromCharCode(65 + index)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFFA3AED0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sector ${index + 1}, Ind. Area',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFA3AED0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.7 - (index * 0.1),
                    backgroundColor: const Color(0xFFF4F7FE),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      index == 0
                          ? const Color(0xFFEF5350)
                          : const Color(0xFF4CAF50),
                    ),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Capacity Usage',
                      style: TextStyle(fontSize: 10, color: Color(0xFFA3AED0)),
                    ),
                    Text(
                      '${(70 - index * 10)}%',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
