import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Preventive Maintenance',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMaintenanceSummary(),
            const SizedBox(height: 32),
            const Text(
              'Upcoming Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 16),
            _buildScheduleItem(
              'CNC Milling Unit 01',
              'Annual Overhaul',
              'Tommorrow',
              Colors.red,
            ),
            _buildScheduleItem(
              'Hydraulic Press B',
              'Oil Change',
              'Feb 05, 2024',
              Colors.orange,
            ),
            _buildScheduleItem(
              'Conveyor Belt 04',
              'Sensor Calibration',
              'Feb 10, 2024',
              Colors.blue,
            ),
            _buildScheduleItem(
              'Air Compressor',
              'Filter Replacement',
              'Feb 12, 2024',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceSummary() {
    return Row(
      children: [
        Expanded(child: _buildSummaryCard('Critical', '02', Colors.red)),
        const SizedBox(width: 16),
        Expanded(child: _buildSummaryCard('Pending', '05', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildSummaryCard('Completed', '24', Colors.green)),
      ],
    );
  }

  Widget _buildSummaryCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    String machine,
    String task,
    String date,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.settings_suggest_rounded, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  machine,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task,
                  style: const TextStyle(
                    color: Color(0xFFA3AED0),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Date',
                style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
