import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class OperationalCostsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const OperationalCostsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Operational Costs',
            subtitle: 'Day-to-day business expenditure',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildCostHeatmap(),
                const SizedBox(height: 24),
                const Text(
                  'Cost Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCostItem(
                  'Rent & Utilities',
                  '\$ 12,000',
                  0.8,
                  Colors.blue,
                ),
                _buildCostItem('Marketing', '\$ 8,500', 0.55, Colors.purple),
                _buildCostItem(
                  'Software Licenses',
                  '\$ 4,300',
                  0.3,
                  Colors.orange,
                ),
                _buildCostItem('Maintenance', '\$ 2,100', 0.15, Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostHeatmap() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Op-Ex Trend',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(Icons.trending_down_rounded, color: Colors.green),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final heights = [40.0, 60.0, 80.0, 100.0, 50.0, 70.0, 90.0];
              return Container(
                width: 30,
                height: heights[index],
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          const Text(
            'Last 7 Days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildCostItem(
    String name,
    String amount,
    double progress,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
