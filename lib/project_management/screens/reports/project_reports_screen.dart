import 'package:flutter/material.dart';

class ProjectReportsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectReportsScreen({super.key, this.onBack, this.onMenu});

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
          'Reports',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildReportCard('Task Completion Rate', '85%'),
            const SizedBox(height: 16),
            _buildReportCard('Budget Burn Rate', '55%'),
            const SizedBox(height: 16),
            _buildReportCard('Team Efficiency', '92%'),
            const SizedBox(height: 16),
            _buildReportCard('Overdue Tasks', '3'),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFA3AED0),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.7, // Mock value
            backgroundColor: const Color(0xFFF4F7FE),
            color: const Color(0xFF4318FF),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
