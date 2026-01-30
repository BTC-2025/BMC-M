import 'package:flutter/material.dart';

class BomScreen extends StatelessWidget {
  const BomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Bill of Materials',
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildBomCard('Steel Chassis Assembly', 'Ver 2.1', '12 Components'),
          _buildBomCard('Circuit Board V4', 'Ver 4.0', '45 Components'),
          _buildBomCard('Hydraulic Pump Unit', 'Ver 1.0', '8 Components'),
          _buildBomCard('Control Panel Box', 'Ver 3.2', '18 Components'),
        ],
      ),
    );
  }

  Widget _buildBomCard(String name, String version, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.layers_outlined,
              color: Color(0xFF1565C0),
              size: 24,
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
                    color: Color(0xFF1B2559),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  version,
                  style: const TextStyle(
                    color: Color(0xFF4318FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            count,
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFFA3AED0),
          ),
        ],
      ),
    );
  }
}
