import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF1B2559),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B2559),
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Configure your ERP Experience',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA3AED0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Section: General
              _buildSectionTitle('General'),
              _buildSettingsCard([
                _buildSettingsItem(
                  Icons.person_outline_rounded,
                  'Account Settings',
                  'Manage your profile and security',
                  Colors.blue,
                ),
                _buildSettingsItem(
                  Icons.notifications_none_rounded,
                  'Notifications',
                  'Customize your alert preferences',
                  Colors.orange,
                ),
                _buildSettingsItem(
                  Icons.language_rounded,
                  'Language',
                  'Current: English (US)',
                  Colors.green,
                ),
              ]),

              const SizedBox(height: 32),

              // Section: Security
              _buildSectionTitle('Security'),
              _buildSettingsCard([
                _buildSettingsItem(
                  Icons.lock_outline_rounded,
                  'Privacy & Security',
                  'Encryption and data privacy',
                  Colors.redAccent,
                ),
                _buildSettingsItem(
                  Icons.fingerprint_rounded,
                  'Biometric Authentication',
                  'Enable Face ID or Fingerprint',
                  Colors.purple,
                ),
                _buildSettingsItem(
                  Icons.history_rounded,
                  'Login Activity',
                  'Check recent login attempts',
                  Colors.indigo,
                ),
              ]),

              const SizedBox(height: 32),

              // Section: About
              _buildSectionTitle('About'),
              _buildSettingsCard([
                _buildSettingsItem(
                  Icons.info_outline_rounded,
                  'App Version',
                  'v2.4.0-premium',
                  Colors.grey,
                ),
                _buildSettingsItem(
                  Icons.description_outlined,
                  'Terms of Service',
                  'Read our usage agreement',
                  Colors.grey,
                ),
                _buildSettingsItem(
                  Icons.policy_outlined,
                  'Privacy Policy',
                  'How we handle your data',
                  Colors.grey,
                ),
              ]),

              const SizedBox(height: 48),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Log Out System',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.redAccent.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA3AED0),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle,
    Color iconTheme,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconTheme.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconTheme, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFFA3AED0),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFA3AED0),
          ),
          onTap: () {},
        ),
        if (title != 'Language' &&
            title != 'Login Activity' &&
            title != 'Privacy Policy')
          const Divider(height: 1, indent: 70, endIndent: 20),
      ],
    );
  }
}
