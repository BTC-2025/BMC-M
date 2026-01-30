import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class PayablesScreen extends StatelessWidget {
  final VoidCallback onBack;

  const PayablesScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Accounts Payable',
            subtitle: 'Money owed to suppliers',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildUpcomingPaymentsCard(),
                const SizedBox(height: 24),
                const Text(
                  'Supplier Balances',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSupplierItem(
                  'AWS Cloud Services',
                  '\$ 4,200',
                  'Due in 5 Days',
                  Colors.blue,
                ),
                _buildSupplierItem(
                  'Office Supply Co',
                  '\$ 850',
                  'Due in 12 Days',
                  Colors.grey,
                ),
                _buildSupplierItem(
                  'Logistics Ltd',
                  '\$ 15,400',
                  'Due in 2 Days',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingPaymentsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Payables',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ 185,200',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.outbox_rounded, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const LinearProgressIndicator(
            value: 0.65,
            backgroundColor: Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation(Color(0xFF0F172A)),
            minHeight: 8,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Settled this week',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
              ),
              Text(
                '\$ 120,000 / \$ 185,200',
                style: TextStyle(
                  color: Color(0xFF0F172A),
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

  Widget _buildSupplierItem(
    String name,
    String amount,
    String due,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(Icons.business_rounded, color: color, size: 20),
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
                  due,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
