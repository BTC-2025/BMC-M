import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class HrmReportsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const HrmReportsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Reports & Analytics',
            subtitle: 'Generate workforce and financial insights',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildReportGrid(),
                const SizedBox(height: 32),
                const Text(
                  'Recent Reports',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildRecentReportItem(
                  'Q4 Payroll Summary',
                  'Yesterday, 4:30 PM',
                  'PDF',
                  Colors.red,
                ),
                _buildRecentReportItem(
                  'Annual Performance Matrix',
                  '2 days ago',
                  'XLSX',
                  Colors.green,
                ),
                _buildRecentReportItem(
                  'Employee Turnover Analysis',
                  'Dec 15, 2023',
                  'CSV',
                  Colors.blue,
                ),
                _buildRecentReportItem(
                  'Training ROI Report',
                  'Dec 10, 2023',
                  'PDF',
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildReportTypeCard(
          'Payroll Analysis',
          Icons.payments_rounded,
          Colors.green,
        ),
        _buildReportTypeCard(
          'Staff Attendance',
          Icons.calendar_today_rounded,
          Colors.blue,
        ),
        _buildReportTypeCard(
          'Gender Diversity',
          Icons.pie_chart_rounded,
          Colors.purple,
        ),
        _buildReportTypeCard(
          'Hiring Pipeline',
          Icons.person_search_rounded,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildReportTypeCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate Now',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReportItem(
    String title,
    String time,
    String format,
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                format,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded, color: Colors.grey, size: 20),
          ),
        ],
      ),
    );
  }
}
