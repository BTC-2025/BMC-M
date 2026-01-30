import 'package:flutter/material.dart';

class ScmDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const ScmDrawer({
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
                colors: [Color(0xFFEF6C00), Color(0xFFFFA726)],
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
                    Icons.fork_right_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supply Chain',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Management',
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
                _buildSectionHeader('Overview'),
                _buildDrawerItem(Icons.dashboard_rounded, 'Overview'),

                const SizedBox(height: 16),
                _buildSectionHeader('Procurement'),
                _buildDrawerItem(Icons.people_alt_rounded, 'Suppliers'),
                _buildDrawerItem(
                  Icons.shopping_cart_checkout_rounded,
                  'Purchase Orders',
                ),
                _buildDrawerItem(Icons.receipt_long_rounded, 'Requisitions'),

                const SizedBox(height: 16),
                _buildSectionHeader('Logistics'),
                _buildDrawerItem(Icons.local_shipping_rounded, 'Shipments'),
                _buildDrawerItem(Icons.map_rounded, 'Tracking'),
                _buildDrawerItem(Icons.warehouse_rounded, 'Warehouses'),

                const SizedBox(height: 16),
                _buildSectionHeader('Analytics'),
                _buildDrawerItem(Icons.bar_chart_rounded, 'Reports'),
              ],
            ),
          ),

          // Bottom Actions
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bolt_rounded,
                      color: Color(0xFFEF6C00),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Optimize Routes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEF6C00),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
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
        color: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFEF6C00) : const Color(0xFF94A3B8),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFFE65100)
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
