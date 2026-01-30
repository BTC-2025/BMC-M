import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../config/app_colors.dart';
import 'route_names.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    final currentRoute = (routeName == '/' || routeName == null)
        ? RouteNames.dashboard
        : routeName;

    return Drawer(
      width: 280,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Custom Gradient Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, const Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12', // Placeholder
                    ),
                    backgroundColor: Colors.white24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Alex Johnson',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'admin@company.com',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                _buildSectionHeader('CORE MODULES'),
                _buildDrawerItem(
                  context,
                  Iconsax.element_4,
                  'Dashboard',
                  RouteNames.dashboard,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.box,
                  'Inventory',
                  RouteNames.inventory,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.people,
                  'CRM',
                  RouteNames.crm,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.user_tag,
                  'HRM',
                  RouteNames.hrm,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.money_2,
                  'Finance',
                  RouteNames.finance,
                  currentRoute,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('OPERATIONS'),
                _buildDrawerItem(
                  context,
                  Iconsax.setting_2,
                  'Manufacturing',
                  RouteNames.manufacturing,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.truck,
                  'SCM',
                  RouteNames.scm,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.folder_open,
                  'Projects',
                  RouteNames.projectManagement,
                  currentRoute,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.grey[200], height: 1),
                ),

                _buildSectionHeader('SYSTEM'),
                _buildDrawerItem(
                  context,
                  Iconsax.chart_square,
                  'Business Intelligence',
                  RouteNames.bi,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.chart_21,
                  'Analytics',
                  RouteNames.analytics,
                  currentRoute,
                ),
                _buildDrawerItem(
                  context,
                  Iconsax.setting,
                  'Settings',
                  RouteNames.settings,
                  currentRoute,
                ),

                // Upgrade Card
                _buildUpgradeCard(context),

                // Footer
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Text(
                    'v2.4.0 • Enterprise Edition',
                    style: TextStyle(color: Colors.grey[400], fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String? routeName,
    String? currentRoute,
  ) {
    final bool isSelected = currentRoute == routeName && routeName != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : const Color(0xFF94A3B8),
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
        onTap: () {
          Navigator.pop(context); // Close drawer
          if (routeName != null && routeName != currentRoute) {
            Navigator.pushNamed(context, routeName);
          }
        },
      ),
    );
  }

  Widget _buildUpgradeCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E3192).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Iconsax.crown, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Upgrade to Pro',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlock advanced features and unlimited reports.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, RouteNames.upgradeToPro);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2E3192),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
