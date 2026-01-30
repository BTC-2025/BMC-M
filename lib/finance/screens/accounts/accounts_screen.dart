import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Bank Accounts',
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
          _buildAccountCard(
            'Main Business Checking',
            '**** 4829',
            '\$245,000.00',
            const Color(0xFF1E88E5),
          ),
          const SizedBox(height: 16),
          _buildAccountCard(
            'Operational Expense',
            '**** 9921',
            '\$32,450.00',
            const Color(0xFF43A047),
          ),
          const SizedBox(height: 16),
          _buildAccountCard(
            'Reserve Savings',
            '**** 1102',
            '\$1,200,000.00',
            const Color(0xFFFB8C00),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(
    String name,
    String number,
    String balance,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.credit_card, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            number,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
