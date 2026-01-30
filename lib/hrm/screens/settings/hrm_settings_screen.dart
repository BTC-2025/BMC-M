import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class HrmSettingsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const HrmSettingsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'HRM Settings',
            subtitle: 'Configure module preferences and access',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSettingsSection('General Configuration', [
                  _buildSettingsItem(
                    'Working Days',
                    'Mon - Fri',
                    Icons.calendar_today_rounded,
                  ),
                  _buildSettingsItem(
                    'Working Hours',
                    '09:00 - 18:00',
                    Icons.access_time_rounded,
                  ),
                  _buildSettingsItem(
                    'Standard Leave Allocation',
                    '24 days/year',
                    Icons.event_available_rounded,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSettingsSection('Payroll Settings', [
                  _buildSettingsItem(
                    'Currency',
                    'USD (\$)',
                    Icons.monetization_on_rounded,
                  ),
                  _buildSettingsItem(
                    'Tax Calculation Method',
                    'Progressive',
                    Icons.calculate_rounded,
                  ),
                  _buildSettingsItem(
                    'Payslip Visibility',
                    'Self-service enabled',
                    Icons.visibility_rounded,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSettingsSection('Approvals & Notifications', [
                  _buildSettingsItem(
                    'Leave Approval Flow',
                    'Manager > HR',
                    Icons.rule_rounded,
                  ),
                  _buildSettingsItem(
                    'Email Alerts',
                    'Enabled',
                    Icons.notifications_active_rounded,
                  ),
                ]),
                const SizedBox(height: 32),
                _buildDangerZone(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA3AED0),
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(String title, String value, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF4776E6), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildDangerZone() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restore Factory Defaults',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Reset all HRM configurations to original state.',
                  style: TextStyle(fontSize: 11, color: Colors.red),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Reset',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
