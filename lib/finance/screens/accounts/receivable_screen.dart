import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class ReceivableScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ReceivableScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Accounts Receivable',
            subtitle: 'Money owed by customers',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAgingSummary(),
                const SizedBox(height: 24),
                const Text(
                  'Top Debtor Balances',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDebtorItem(
                  'Acme Corp',
                  '\$ 45,000',
                  '15 Days Overdue',
                  Colors.orange,
                ),
                _buildDebtorItem(
                  'Globex',
                  '\$ 22,000',
                  'Current',
                  Colors.green,
                ),
                _buildDebtorItem(
                  'Stark Industries',
                  '\$ 88,200',
                  '45 Days Overdue',
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgingSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            'Total Outstanding',
            style: TextStyle(color: Colors.white70),
          ),
          const Text(
            '\$ 420,500',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAgingCol('0-30', '\$ 280K', Colors.green),
              _buildAgingCol('31-60', '\$ 95K', Colors.orange),
              _buildAgingCol('60+', '\$ 45K', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgingCol(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildDebtorItem(
    String name,
    String balance,
    String status,
    Color color,
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
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: const Icon(Icons.person_outline_rounded),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            balance,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
