import 'package:flutter/material.dart';

class AnalyticsDashboard extends StatelessWidget {
  const AnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'System Analytics',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Activity Graph Placeholder
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2B3674), Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2B3674).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Activity',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '2,450 Active Sessions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Mock Graph
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildGraphBar(0.4),
                      _buildGraphBar(0.6),
                      _buildGraphBar(0.8),
                      _buildGraphBar(0.5),
                      _buildGraphBar(0.9),
                      _buildGraphBar(0.7),
                      _buildGraphBar(0.6),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // System Health CArds
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard('Error Rate', '0.02%', Colors.green),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard('Avg Latency', '45ms', Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard('API Calls', '1.2M', Colors.purple),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard('Storage Used', '45%', Colors.orange),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Logs
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent System Events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLogItem(
              'System Backup Completed',
              '02:00 AM',
              Icons.cloud_done,
              Colors.green,
            ),
            _buildLogItem(
              'Failed Login Attempt (IP: 192...)',
              '09:15 AM',
              Icons.warning,
              Colors.red,
            ),
            _buildLogItem(
              'New Module Deployed',
              'Yesterday',
              Icons.rocket_launch,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphBar(double heightFactor) {
    return Container(
      width: 20,
      height: 80 * heightFactor,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(
    String message,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
                fontSize: 13,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
