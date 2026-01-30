import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class DepreciationLogScreen extends StatelessWidget {
  final VoidCallback onBack;

  const DepreciationLogScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Depreciation Log',
            subtitle: 'Amortization schedules & write-offs',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSummaryHeader(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Log Entries',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildLogEntry(
                  'IT Hardware Batch A',
                  'Straight Line',
                  '-\$ 2,400',
                  'Jan 2024',
                ),
                _buildLogEntry(
                  'Delivery Van 2022',
                  'Reducing Balance',
                  '-\$ 1,800',
                  'Jan 2024',
                ),
                _buildLogEntry(
                  'Office Furniture',
                  'Straight Line',
                  '-\$ 450',
                  'Jan 2024',
                ),
                _buildLogEntry(
                  'Lab Equipment',
                  'Units of Production',
                  '-\$ 3,200',
                  'Jan 2024',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Mo. Depreciation',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$ 7,850',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(Icons.history_rounded, color: Color(0xFF64748B), size: 32),
        ],
      ),
    );
  }

  Widget _buildLogEntry(
    String asset,
    String method,
    String value,
    String period,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Method: $method',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFFEF4444),
                ),
              ),
              Text(
                period,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
