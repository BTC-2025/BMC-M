import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class TaxComplianceScreen extends StatelessWidget {
  final VoidCallback onBack;

  const TaxComplianceScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Tax Compliance',
            subtitle: 'Fiscal reporting & obligations',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildTaxObligationCard(),
                const SizedBox(height: 24),
                const Text(
                  'Tax Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTaxItem(
                  'Value Added Tax (VAT)',
                  '\$ 18,400',
                  'Due in 15 days',
                  0.8,
                ),
                _buildTaxItem(
                  'Corporate Income Tax',
                  '\$ 45,200',
                  'Due in 45 days',
                  0.45,
                ),
                _buildTaxItem('Payroll Tax', '\$ 8,100', 'Settled', 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxObligationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.gavel_rounded, color: Colors.white, size: 32),
          const SizedBox(height: 16),
          const Text(
            'Total Tax Provision',
            style: TextStyle(color: Colors.white70),
          ),
          const Text(
            '\$ 71,700',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'All reports up to date',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxItem(
    String name,
    String amount,
    String status,
    double progress,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: progress == 1.0 ? Colors.green : Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation(
              progress == 1.0 ? Colors.green : const Color(0xFF0F172A),
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
