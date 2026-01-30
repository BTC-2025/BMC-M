import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class BonusDeductionsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const BonusDeductionsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Bonus & Deductions',
            subtitle: 'Manage adjustments to employee payroll',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSummaryCards(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildAdjustmentItem(
                  'Performance Bonus',
                  'John Doe',
                  '+\$1,200',
                  'Dec 24',
                  Colors.green,
                ),
                _buildAdjustmentItem(
                  'Health Premium',
                  'Sarah Conon',
                  '-\$150',
                  'Dec 22',
                  Colors.red,
                ),
                _buildAdjustmentItem(
                  'Referral Bonus',
                  'Mike Ross',
                  '+\$500',
                  'Dec 20',
                  Colors.green,
                ),
                _buildAdjustmentItem(
                  'Late Deduction',
                  'Alice Smith',
                  '-\$50',
                  'Dec 18',
                  Colors.red,
                ),
                _buildAdjustmentItem(
                  'Annual Bonus',
                  'Organization-wide',
                  '+\$15,000',
                  'Dec 15',
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        _buildSummaryCard(
          'Total Bonuses',
          '\$24,500',
          Icons.trending_up_rounded,
          Colors.green,
        ),
        const SizedBox(width: 16),
        _buildSummaryCard(
          'Total Deductions',
          '\$3,200',
          Icons.trending_down_rounded,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdjustmentItem(
    String title,
    String employee,
    String amount,
    String date,
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              amount.startsWith('+')
                  ? Icons.add_circle_outline_rounded
                  : Icons.remove_circle_outline_rounded,
              color: color,
              size: 22,
            ),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
