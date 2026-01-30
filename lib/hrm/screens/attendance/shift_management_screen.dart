import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class ShiftManagementScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ShiftManagementScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Shift Management',
            subtitle: 'Schedule employee shifts',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildShiftOverview(),
                const SizedBox(height: 24),
                const Text(
                  'Upcoming Shifts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildShiftCard(
                  'Morning Shift',
                  '09:00 AM - 05:00 PM',
                  '124 Staff',
                  Colors.blue,
                ),
                _buildShiftCard(
                  'Evening Shift',
                  '05:00 PM - 01:00 AM',
                  '86 Staff',
                  Colors.orange,
                ),
                _buildShiftCard(
                  'Night Shift',
                  '01:00 AM - 09:00 AM',
                  '38 Staff',
                  Colors.purple,
                ),
                _buildShiftCard(
                  'Support Shift',
                  '02:00 PM - 10:00 PM',
                  '24 Staff',
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Shift',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Morning Shift',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.wb_sunny_rounded, color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: 0.65,
            backgroundColor: Colors.grey[100],
            color: const Color(0xFF4776E6),
            borderRadius: BorderRadius.circular(10),
            minHeight: 10,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4 hours remaining',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const Text(
                '65% complete',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(
    String title,
    String time,
    String staffCount,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.schedule_rounded, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                staffCount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Text(
                'Assigned',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
