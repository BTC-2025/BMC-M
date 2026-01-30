import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Invoices',
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
          _buildInvoiceCard(
            'INV-2024-001',
            'Acme Corp',
            '\$12,500',
            'Paid',
            Colors.green,
          ),
          _buildInvoiceCard(
            'INV-2024-002',
            'Globex Inc',
            '\$3,200',
            'Pending',
            Colors.orange,
          ),
          _buildInvoiceCard(
            'INV-2024-003',
            'Soylent Corp',
            '\$8,450',
            'Overdue',
            Colors.red,
          ),
          _buildInvoiceCard(
            'INV-2024-004',
            'Initech',
            '\$1,100',
            'Paid',
            Colors.green,
          ),
          _buildInvoiceCard(
            'INV-2024-005',
            'Umbrella Corp',
            '\$50,000',
            'Pending',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(
    String id,
    String client,
    String amount,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                client,
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
