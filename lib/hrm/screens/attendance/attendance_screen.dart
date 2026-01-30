import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';
import '../../widgets/attendance_calendar.dart';

class AttendanceScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AttendanceScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Attendance',
            subtitle: 'Track presence and work hours',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAttendanceSummary(),
                const SizedBox(height: 24),
                const AttendanceCalendar(),
                const SizedBox(height: 24),
                _buildSectionTitle('Today\'s Log'),
                const SizedBox(height: 12),
                _buildAttendanceLogItem(
                  'Check In',
                  '09:05 AM',
                  Icons.login_rounded,
                  Colors.green,
                ),
                _buildAttendanceLogItem(
                  'Check Out',
                  '06:12 PM',
                  Icons.logout_rounded,
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Present', '22', Colors.white),
          _buildSummaryItem('Absent', '2', Colors.white70),
          _buildSummaryItem('Late', '3', Colors.white70),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
        ),
      ],
    );
  }

  Widget _buildAttendanceLogItem(
    String action,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            action,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const Spacer(),
          Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
