import 'package:flutter/material.dart';

class InventoryDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const InventoryDrawer({
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
                colors: [Color(0xFF6B7FD7), Color(0xFF9B8AFB)],
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
                    Icons.inventory_2_rounded,
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
                      'StockMaster',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Inventory Pro',
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
                _buildSectionHeader('CORE INVENTORY'),
                _buildDrawerItem(Icons.dashboard_rounded, 'Overview'),
                _buildDrawerItem(Icons.shopping_bag_rounded, 'Products'),
                _buildDrawerItem(Icons.category_rounded, 'Categories'),
                _buildDrawerItem(Icons.inventory_rounded, 'Stock Levels'),
                _buildDrawerItem(Icons.arrow_downward_rounded, 'Stock In'),
                _buildDrawerItem(Icons.arrow_upward_rounded, 'Stock Out'),
                _buildDrawerItem(Icons.local_shipping_rounded, 'Suppliers'),
                _buildDrawerItem(Icons.analytics_outlined, 'Reports'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('OPERATIONS'),
                _buildDrawerItem(Icons.description_rounded, 'Purchase Orders'),
                _buildDrawerItem(Icons.request_quote_rounded, 'Sales Orders'),
                _buildDrawerItem(
                  Icons.notification_important_rounded,
                  'Reorder Alerts',
                ),
                _buildDrawerItem(Icons.assignment_return_rounded, 'Returns'),
                _buildDrawerItem(Icons.swap_horiz_rounded, 'Stock Transfer'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('TRACKING & LOCATIONS'),
                _buildDrawerItem(Icons.store_rounded, 'Warehouses'),
                _buildDrawerItem(Icons.qr_code_2_rounded, 'Batch Tracking'),
                _buildDrawerItem(Icons.pin_rounded, 'Serial Numbers'),
                _buildDrawerItem(Icons.qr_code_scanner_rounded, 'Barcode'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('CONFIGURATION'),
                _buildDrawerItem(Icons.straighten_rounded, 'UOM'),
                _buildDrawerItem(Icons.edit_note_rounded, 'Adjustments'),
                _buildDrawerItem(
                  Icons.currency_exchange_rounded,
                  'Tax & Currency',
                ),
                _buildDrawerItem(Icons.insights_rounded, 'Analytics'),
              ],
            ),
          ),

          // Bottom Version Info
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'v2.4.0 • Enterprise Edition',
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
        color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: const Color(0xFF6B7FD7).withValues(alpha: 0.3))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF4A55A2) : const Color(0xFF94A3B8),
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
