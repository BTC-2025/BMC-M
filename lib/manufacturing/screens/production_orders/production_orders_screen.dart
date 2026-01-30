import 'package:flutter/material.dart';

class ProductionOrdersScreen extends StatelessWidget {
  const ProductionOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Production Orders',
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
          _buildOrderCard('PO-2024-882', 'Steel Chassis', 0.8, 'In Progress'),
          _buildOrderCard('PO-2024-890', 'Circuit Boards', 0.2, 'Started'),
          _buildOrderCard('PO-2024-901', 'Hydraulic Pump', 0.0, 'Planned'),
          _buildOrderCard('PO-2024-875', 'Control Panel', 1.0, 'Completed'),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    String id,
    String product,
    double progress,
    String status,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                      (progress == 1.0
                              ? Colors.green
                              : (progress > 0 ? Colors.blue : Colors.grey))
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: progress == 1.0
                        ? Colors.green
                        : (progress > 0 ? Colors.blue : Colors.grey),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product,
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFF4F7FE),
            color: const Color(0xFF4318FF),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4318FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
