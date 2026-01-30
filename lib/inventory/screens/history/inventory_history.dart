import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryHistory extends StatelessWidget {
  const InventoryHistory({super.key});

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
                title: 'History',
                subtitle: 'Track stock movements',
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: 15,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildTransactionTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(int index) {
    bool isStockIn = index % 2 == 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isStockIn
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isStockIn
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: isStockIn
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFEF5350),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isStockIn ? 'Stock Received' : 'Stock Dispatched',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item: Product #${101 + index}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      'Jan ${10 + index}, 2026 • 10:30 AM',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA3AED0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isStockIn ? '+${(index + 1) * 10}' : '-${(index + 1) * 5}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isStockIn
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFEF5350),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFA3AED0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
