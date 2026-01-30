import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class DataModelScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const DataModelScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'Data Model (Admin)',
                subtitle: 'Manage data sources and connections',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildDataModelCard(
                    'Sales Transactions',
                    'Source: PostgreSQL',
                    'Active',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildDataModelCard(
                    'Inventory Logs',
                    'Source: PostgreSQL',
                    'Active',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildDataModelCard(
                    'Web Traffic',
                    'Source: Google Analytics',
                    'Linked',
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataModelCard(
    String name,
    String source,
    String status,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF9F5FF,
        ), // Light purple background from reference
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // Simple icon placeholder, or could use an icon
              color: Colors.transparent,
            ),
            child: const Icon(
              Iconsax.hierarchy_square_2,
              color: Color(0xFF4318FF),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF707EAE), // Muted text color
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D189), // Green from reference
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
