import 'package:flutter/material.dart';

class AssetsDashboard extends StatelessWidget {
  const AssetsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Assets Dashboard',
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
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Value',
                    '\$450,200',
                    Icons.monetization_on,
                    const Color(0xFF4318FF),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    'Total Assets',
                    '142',
                    Icons.inventory_2,
                    const Color(0xFF05CD99),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Health Status
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                  const Text(
                    'Asset Health',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildHealthBar('Operational', 0.85, Colors.green),
                  const SizedBox(height: 12),
                  _buildHealthBar('Maintenance', 0.10, Colors.orange),
                  const SizedBox(height: 12),
                  _buildHealthBar('Broken/Retired', 0.05, Colors.red),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Alerts
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Maintenance Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildAlertTile(
              'CNC Machine Maintenance Due',
              'Urgent',
              Colors.red,
            ),
            _buildAlertTile(
              'Vehicle Registration Expiring',
              'Warning',
              Colors.orange,
            ),
            _buildAlertTile('Laptop Replacement Cycle', 'Info', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1B2559),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthBar(String label, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            Text(
              '${(pct * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFA3AED0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: pct,
          color: color,
          backgroundColor: const Color(0xFFF4F7FE),
          borderRadius: BorderRadius.circular(4),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildAlertTile(String message, String type, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
              fontSize: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
