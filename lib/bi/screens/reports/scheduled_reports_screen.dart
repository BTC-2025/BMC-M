import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class ScheduledReportsScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ScheduledReportsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF4318FF),
        elevation: 10,
        icon: const Icon(Icons.add_alarm, color: Colors.white),
        label: const Text(
          'New Schedule',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'Scheduled Reports',
                subtitle: 'Automated data delivery',
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
                  _buildScheduleCard(
                    'Weekly Sales',
                    'Every Monday at 9:00 AM',
                    'Sales Dept',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildScheduleCard(
                    'Monthly Inventory',
                    '1st of every month at 8:00 AM',
                    'Warehouse',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildScheduleCard(
                    'Quarterly Financials',
                    'Every 3 months',
                    'Finance',
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildScheduleCard(
                    'Daily Operations',
                    'Every day at 6:00 PM',
                    'Ops Team',
                    true,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(
    String title,
    String timing,
    String recipient,
    bool isActive,
  ) {
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
              color: isActive
                  ? const Color(0xFF4318FF).withValues(alpha: 0.1)
                  : const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Iconsax.calendar_tick,
              color: isActive
                  ? const Color(0xFF4318FF)
                  : const Color(0xFFA3AED0),
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
                  timing,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4318FF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'To: $recipient',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (val) {},
            activeTrackColor: const Color(0xFF4318FF),
          ),
        ],
      ),
    );
  }
}
