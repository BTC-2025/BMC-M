import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class PayslipsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const PayslipsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Payslips',
            subtitle: 'Access and download your salary statements',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSearchAndFilter(),
                const SizedBox(height: 24),
                _buildPayslipItem(
                  'December 2023',
                  'Downloaded',
                  '\$8,500.00',
                  true,
                ),
                _buildPayslipItem(
                  'November 2023',
                  'Downloaded',
                  '\$8,500.00',
                  true,
                ),
                _buildPayslipItem(
                  'October 2023',
                  'Available',
                  '\$8,500.00',
                  false,
                ),
                _buildPayslipItem(
                  'September 2023',
                  'Available',
                  '\$8,200.00',
                  false,
                ),
                _buildPayslipItem(
                  'August 2023',
                  'Available',
                  '\$8,200.00',
                  false,
                ),
                _buildPayslipItem(
                  'July 2023',
                  'Available',
                  '\$8,200.00',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEF2FF)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search payslips...',
                border: InputBorder.none,
                icon: Icon(Icons.search_rounded, color: Colors.grey, size: 20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF4776E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.filter_list_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildPayslipItem(
    String month,
    String status,
    String amount,
    bool isDownloaded,
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Color(0xFF4776E6),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: isDownloaded ? Colors.green : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.download_rounded,
                size: 18,
                color: Color(0xFF4776E6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
