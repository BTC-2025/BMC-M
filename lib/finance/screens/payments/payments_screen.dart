import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Payments',
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
          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            'AWS Cloud Services',
            'May 20, 2024',
            '-\$450.00',
            false,
          ),
          _buildTransactionItem(
            'Client Payment - Invoice #001',
            'May 19, 2024',
            '+\$12,500.00',
            true,
          ),
          _buildTransactionItem(
            'Office Rent',
            'May 01, 2024',
            '-\$3,000.00',
            false,
          ),
          _buildTransactionItem(
            'Refund issued',
            'Apr 28, 2024',
            '-\$120.00',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    bool isIncoming,
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isIncoming
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncoming ? Colors.green : Colors.red,
              size: 20,
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
                    color: Color(0xFF1B2559),
                    fontSize: 14,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFFA3AED0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isIncoming ? Colors.green : Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
