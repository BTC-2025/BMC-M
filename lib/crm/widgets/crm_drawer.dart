import 'package:flutter/material.dart';

class CrmDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const CrmDrawer({
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
                  Color(0xFF2E3192),
                  Color(0xFF1BFFFF),
                ], // CRM Theme Gradient
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
                    Icons.people_alt_rounded,
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
                      'CRM Pro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Manage Relationships',
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
                _buildDrawerItem(Icons.dashboard_rounded, 'Overview'),
                _buildDrawerItem(Icons.person_add_alt_1_rounded, 'Leads'),
                _buildDrawerItem(Icons.groups_rounded, 'Customers'), // Accounts
                _buildDrawerItem(
                  Icons.perm_contact_calendar_rounded,
                  'Contacts',
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildDrawerItem(Icons.handshake_rounded, 'Deal Pipeline'),
                _buildDrawerItem(Icons.task_alt_rounded, 'Tasks'), // Activities
                _buildDrawerItem(Icons.mail_outline_rounded, 'Communication'),
                _buildDrawerItem(Icons.campaign_rounded, 'Campaigns'),
                _buildDrawerItem(
                  Icons.support_agent_rounded,
                  'Support Tickets',
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildDrawerItem(Icons.inventory_2_rounded, 'Products'),
                _buildDrawerItem(Icons.receipt_long_rounded, 'Quotes'),
                _buildDrawerItem(Icons.manage_accounts_rounded, 'Users'),
                _buildDrawerItem(Icons.analytics_rounded, 'Reports'),
                _buildDrawerItem(Icons.settings_rounded, 'Settings'),
              ],
            ),
          ),

          // Bottom Version Info
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'v1.0.0 • CRM Module',
              style: TextStyle(color: Colors.grey[400], fontSize: 11),
            ),
          ),
        ],
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
