import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class AssetRegistryScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AssetRegistryScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Asset Registry',
            subtitle: 'Detailed record of company holdings',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSearchAndFilter(),
                const SizedBox(height: 24),
                _buildAssetRecord(
                  'MacBook Pro M3 Max',
                  'AST-9921',
                  '\$ 4,500',
                  'Active',
                  Colors.blue,
                ),
                _buildAssetRecord(
                  'Herman Miller Aeron',
                  'AST-4412',
                  '\$ 1,200',
                  'Active',
                  Colors.brown,
                ),
                _buildAssetRecord(
                  'Tesla Model 3',
                  'AST-1102',
                  '\$ 42,000',
                  'Active',
                  Colors.orange,
                ),
                _buildAssetRecord(
                  'Office Building A',
                  'AST-0001',
                  '\$ 850,000',
                  'Appreciating',
                  Colors.green,
                ),
                _buildAssetRecord(
                  'Old Projector',
                  'AST-0522',
                  '\$ 500',
                  'Retired',
                  Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search asset by ID or Name...',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          border: InputBorder.none,
          icon: Icon(Icons.search, size: 20),
        ),
      ),
    );
  }

  Widget _buildAssetRecord(
    String name,
    String id,
    String value,
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
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.qr_code_2_rounded, color: color),
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
                    fontSize: 15,
                  ),
                ),
                Text(
                  'ID: $id',
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
