import 'package:flutter/material.dart';

class HrmDrawer extends StatelessWidget {
  final Function(String) onItemTapped;
  final String selectedItem;

  const HrmDrawer({
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
                colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
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
                    Icons.badge_rounded,
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
                      'HRM Pro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Talent Management',
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
                _buildSectionHeader('PEOPLE'),
                _buildDrawerItem(Icons.dashboard_rounded, 'Overview'),
                _buildDrawerItem(Icons.people_alt_rounded, 'Employees'),
                _buildDrawerItem(Icons.account_tree_rounded, 'Departments'),
                _buildDrawerItem(Icons.work_rounded, 'Designations'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('TIME & LEAVE'),
                _buildDrawerItem(Icons.calendar_month_rounded, 'Attendance'),
                _buildDrawerItem(Icons.event_note_rounded, 'Leave Requests'),
                _buildDrawerItem(Icons.history_rounded, 'Shift Management'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('FINANCE'),
                _buildDrawerItem(Icons.payments_rounded, 'Payroll'),
                _buildDrawerItem(Icons.receipt_long_rounded, 'Payslips'),
                _buildDrawerItem(Icons.add_card_rounded, 'Bonus & Deductions'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('TALENT & GROWTH'),
                _buildDrawerItem(Icons.person_add_rounded, 'Recruitment'),
                _buildDrawerItem(Icons.trending_up_rounded, 'Performance'),
                _buildDrawerItem(Icons.school_rounded, 'Training'),

                _buildSectionHeader('OPERATIONS'),
                _buildDrawerItem(Icons.inventory_2_rounded, 'Assets'),
                _buildDrawerItem(
                  Icons.account_balance_wallet_rounded,
                  'Expenses',
                ),
                _buildDrawerItem(Icons.celebration_rounded, 'Holidays'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('EXIT'),
                _buildDrawerItem(Icons.exit_to_app_rounded, 'Resignation'),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('ADMIN'),
                _buildDrawerItem(Icons.policy_rounded, 'Company Policy'),
                _buildDrawerItem(Icons.analytics_outlined, 'Reports'),
                _buildDrawerItem(Icons.settings_suggest_rounded, 'Settings'),
              ],
            ),
          ),

          // Bottom Version Info
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'v1.2.0 • HRM Enterprise',
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
        color: isSelected ? const Color(0xFFEEF7FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: const Color(0xFF4776E6).withValues(alpha: 0.3))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF4776E6) : const Color(0xFF94A3B8),
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
