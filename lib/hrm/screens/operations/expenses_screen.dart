import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class ExpensesScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ExpensesScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Expense Claims',
            subtitle: 'Reimbursement and business spend',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSummarySection(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Claims',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildExpenseItem(
                  'Business Travel',
                  'Alex Johnson',
                  '\$450.00',
                  'Approved',
                  Colors.green,
                ),
                _buildExpenseItem(
                  'Client Lunch',
                  'Sarah Conon',
                  '\$85.50',
                  'Pending',
                  Colors.orange,
                ),
                _buildExpenseItem(
                  'Office Supplies',
                  'Mike Ross',
                  '\$120.00',
                  'Approved',
                  Colors.green,
                ),
                _buildExpenseItem(
                  'Software SaaS',
                  'Diana Ross',
                  '\$299.00',
                  'Rejected',
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        _buildSummaryBox('Pending', '\$1,240', Colors.orange),
        const SizedBox(width: 12),
        _buildSummaryBox('Paid', '\$8,450', Colors.blue),
      ],
    );
  }

  Widget _buildSummaryBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(
    String title,
    String employee,
    String amount,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEF2FF)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(Icons.receipt_long_rounded, color: color, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  employee,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
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
