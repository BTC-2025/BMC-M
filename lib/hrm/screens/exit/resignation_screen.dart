import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class ResignationScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ResignationScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Resignations',
            subtitle: 'Manage employee exit and clearance',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildExitProgressCard(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Resignations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildResignationItem(
                  'Alice Smith',
                  'Jan 15, 2024',
                  'Feb 15, 2024',
                  'In Progress',
                  Colors.orange,
                ),
                _buildResignationItem(
                  'Bob Martin',
                  'Dec 01, 2023',
                  'Dec 31, 2023',
                  'Completed',
                  Colors.green,
                ),
                _buildResignationItem(
                  'Charlie Day',
                  'Jan 10, 2024',
                  'Feb 10, 2024',
                  'Pending Approval',
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExitProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exit Clearance Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildClearanceStep('IT Assets Returned', true),
          _buildClearanceStep('ID/Access Cards Handover', true),
          _buildClearanceStep('Final Dues Settlement', false),
          _buildClearanceStep('Exit Interview', false),
        ],
      ),
    );
  }

  Widget _buildClearanceStep(String title, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: isDone ? Colors.green : Colors.white38,
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isDone ? Colors.white : Colors.white70,
              fontSize: 13,
              fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResignationItem(
    String name,
    String applied,
    String lastDay,
    String status,
    Color color,
  ) {
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
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
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
                  'Last Day: $lastDay',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
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
