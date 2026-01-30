import 'package:flutter/material.dart';
import '../../widgets/crm_header.dart';

class CrmSettingsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CrmSettingsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: CrmHeader(
                  title: 'Settings',
                  subtitle: 'Configure CRM',
                  onBack: onBack,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSectionTitle('General configuration'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    Icons.tune_rounded,
                    'Pipeline Stages',
                    'Configure deal stages',
                  ),
                  _buildSettingItem(
                    Icons.category_rounded,
                    'Lead Sources',
                    'Manage acquisition channels',
                  ),
                  _buildSettingItem(
                    Icons.tag_rounded,
                    'Tags & Labels',
                    'Custom categorization',
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Notifications'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    Icons.notifications_active_rounded,
                    'Email Alerts',
                    'Get notified on updates',
                    hasSwitch: true,
                  ),
                  _buildSettingItem(
                    Icons.task_alt_rounded,
                    'Task Reminders',
                    'Daily digest emails',
                    hasSwitch: true,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Team Management'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    Icons.manage_accounts_rounded,
                    'Roles & Permissions',
                    'Access control settings',
                  ),
                  _buildSettingItem(
                    Icons.group_add_rounded,
                    'Invite Members',
                    'Add new team members',
                  ),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA3AED0),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle, {
    bool hasSwitch = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF4A55A2), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA3AED0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (hasSwitch)
            Switch(
              value: true,
              onChanged: (val) {},
              activeThumbColor: const Color(0xFF4318FF),
              activeTrackColor: const Color(0xFFE0E5F2),
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE0E5F2)),
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFA3AED0),
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}
