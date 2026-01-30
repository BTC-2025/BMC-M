import 'package:flutter/material.dart';

class ProjectSettingsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectSettingsScreen({super.key, this.onBack, this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: const Text(
          'Project Settings',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (onMenu != null)
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
              onPressed: onMenu,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsGroup('General', [
            _buildSettingsTile('Project Notifications', true),
            _buildSettingsTile('Task Reminders', true),
            _buildSettingsTile('Weekly Reports', false),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup('Access', [
            _buildSettingsTile('Private Project', true),
            _buildSettingsTile('Guest Access', false),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA3AED0),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(String title, bool value) {
    return SwitchListTile(
      value: value,
      onChanged: (val) {},
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B2559),
        ),
      ),
      activeThumbColor: const Color(0xFF4318FF),
    );
  }
}
