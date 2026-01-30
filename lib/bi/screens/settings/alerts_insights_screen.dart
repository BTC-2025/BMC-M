import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class AlertsInsightsScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const AlertsInsightsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'Alerts & Insights',
                subtitle: 'Configure automated notifications',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildAlertCard(
                    'Stock Low Warning',
                    'Notify when stock level drops below 10%',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildAlertCard(
                    'High Return Rate',
                    'Notify when weekly returns exceed 5%',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildAlertCard(
                    'Revenue Dip',
                    'Notify if daily revenue drops > 15%',
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildAlertCard(
                    'New User Spike',
                    'Notify when new signups increase > 20%',
                    true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(String title, String condition, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEE5D50).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Iconsax.notification_bing,
              color: Color(0xFFEE5D50),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  condition,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA3AED0),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (val) {},
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4318FF),
          ),
        ],
      ),
    );
  }
}
