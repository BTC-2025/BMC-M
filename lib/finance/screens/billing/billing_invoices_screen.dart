import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class BillingInvoicesScreen extends StatelessWidget {
  final VoidCallback onBack;

  const BillingInvoicesScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Billing & Invoices',
            subtitle: 'Generate and track customer billing',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildInvoiceStats(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Invoices',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Filter')),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInvoiceItem(
                  'INV-2024-001',
                  'Global Tech Inc',
                  '\$ 12,500',
                  'Paid',
                  Colors.green,
                ),
                _buildInvoiceItem(
                  'INV-2024-002',
                  'Acme Products',
                  '\$ 8,200',
                  'Overdue',
                  Colors.red,
                ),
                _buildInvoiceItem(
                  'INV-2024-003',
                  'Apex Solutions',
                  '\$ 4,300',
                  'Pending',
                  Colors.orange,
                ),
                _buildInvoiceItem(
                  'INV-2024-004',
                  'Starlight Co',
                  '\$ 15,000',
                  'Draft',
                  Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('Total Billed', '\$ 450K'),
          const VerticalDivider(),
          _buildStat('Unpaid', '\$ 85K'),
          const VerticalDivider(),
          _buildStat('Avg. Cycle', '12 Days'),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF0F172A),
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
      ],
    );
  }

  Widget _buildInvoiceItem(
    String id,
    String client,
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(Icons.description_outlined, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  client,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
