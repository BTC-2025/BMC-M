import 'package:flutter/material.dart';

class ManufacturingDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const ManufacturingDrawer({
    super.key,
    required this.onItemTapped,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Custom Gradient Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2E7D32),
                  Color(0xFF66BB6A),
                ], // Green Gradient for Manufacturing
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.precision_manufacturing_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'FactoryPro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Manufacturing',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                _buildSectionHeader('CORE PRODUCTION'),
                _buildDrawerItem(Icons.dashboard_rounded, 'Overview'),
                _buildDrawerItem(Icons.assignment_ind_rounded, 'Work Orders'),
                _buildDrawerItem(
                  Icons.calendar_month_rounded,
                  'Production Planning',
                ),
                _buildDrawerItem(
                  Icons.account_tree_rounded,
                  'Bill of Materials',
                ),
                _buildDrawerItem(
                  Icons.inventory_2_rounded,
                  'Material Consumption',
                ),
                _buildDrawerItem(
                  Icons.check_circle_outline_rounded,
                  'Finished Goods',
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('SHOP FLOOR'),
                _buildDrawerItem(
                  Icons.settings_input_component_rounded,
                  'Machine Status',
                ),
                _buildDrawerItem(Icons.build_circle_rounded, 'Maintenance'),
                _buildDrawerItem(Icons.timer_rounded, 'Downtime Log'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('REPORTS'),
                _buildDrawerItem(Icons.analytics_rounded, 'Production Reports'),
                _buildDrawerItem(Icons.payments_rounded, 'Production Costing'),
                _buildDrawerItem(Icons.fact_check_rounded, 'QC Inspections'),
                _buildDrawerItem(Icons.pie_chart_rounded, 'Efficiency Stats'),
              ],
            ),
          ),

          // Bottom Version Info
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'v1.1.0 • Manufacturing Module',
              style: TextStyle(color: Colors.grey[400], fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA3AED0),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    final bool isSelected = selectedItem == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFE8F5E9)
            : Colors.transparent, // Greenish selection
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: const Color(0xFF66BB6A).withValues(alpha: 0.3))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF94A3B8),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF1E293B)
                : const Color(0xFF64748B),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () => onItemTapped(title),
      ),
    );
  }
}
