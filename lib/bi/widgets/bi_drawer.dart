import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BiDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const BiDrawer({
    super.key,
    required this.onItemTapped,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Drawer Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2E3192),
                  Color(0xFF1BFFFF),
                ], // Deep Blue to Cyan
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.chart_square,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Business',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Intelligence',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                _buildSectionHeader('Dashboards'),
                _buildDrawerItem(Iconsax.monitor, 'Executive Overview'),
                _buildDrawerItem(Iconsax.category, 'Module Analytics'),
                _buildDrawerItem(Iconsax.radar_2, 'Cross-Module Intelligence'),

                const SizedBox(height: 16),
                _buildSectionHeader('Customization'),
                _buildDrawerItem(Iconsax.grid_edit, 'Custom Dashboards'),
                _buildDrawerItem(Iconsax.firstline, 'KPI Builder'),

                const SizedBox(height: 16),
                _buildSectionHeader('Reports & Alerts'),
                _buildDrawerItem(Iconsax.document_text, 'Reports Builder'),
                _buildDrawerItem(Iconsax.calendar_tick, 'Scheduled Reports'),
                _buildDrawerItem(
                  Iconsax.notification_bing,
                  'Alerts & Insights',
                ),

                const SizedBox(height: 16),
                _buildSectionHeader('Administration'),
                _buildDrawerItem(Iconsax.data, 'Data Model'),
              ],
            ),
          ),

          // Bottom Version Info
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'BI Module v1.0.0',
              style: TextStyle(color: Colors.grey[400], fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA3AED0),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    final bool isSelected = selectedItem == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE0F7FA) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF006064) : const Color(0xFF94A3B8),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF006064)
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
