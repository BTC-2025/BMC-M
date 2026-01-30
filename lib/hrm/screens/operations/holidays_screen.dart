import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class HolidaysScreen extends StatelessWidget {
  final VoidCallback onBack;

  const HolidaysScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Holidays',
            subtitle: 'Company holiday calendar 2024',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHolidayItem(
                  'New Year\'s Day',
                  'Jan 01, 2024',
                  'National',
                  Colors.blue,
                ),
                _buildHolidayItem(
                  'Founder\'s Day',
                  'Feb 12, 2024',
                  'Company',
                  Colors.purple,
                ),
                _buildHolidayItem(
                  'Good Friday',
                  'Mar 29, 2024',
                  'Public',
                  Colors.green,
                ),
                _buildHolidayItem(
                  'Labor Day',
                  'May 01, 2024',
                  'National',
                  Colors.blue,
                ),
                _buildHolidayItem(
                  'Independence Day',
                  'Jul 04, 2024',
                  'National',
                  Colors.blue,
                ),
                _buildHolidayItem(
                  'End of Year Break',
                  'Dec 25 - Dec 31',
                  'Company',
                  Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayItem(String name, String date, String type, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEF2FF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.celebration_rounded, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
