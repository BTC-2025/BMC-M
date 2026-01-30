import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class ChartOfAccountsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ChartOfAccountsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Chart of Accounts',
            subtitle: 'Standard ledger classification',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAccountGroup('Assets (1000 - 1999)', [
                  {
                    'code': '1010',
                    'name': 'Cash in Bank',
                    'balance': '\$ 1.2M',
                  },
                  {
                    'code': '1020',
                    'name': 'Accounts Receivable',
                    'balance': '\$ 420K',
                  },
                  {
                    'code': '1510',
                    'name': 'Office Equipment',
                    'balance': '\$ 55K',
                  },
                ]),
                const SizedBox(height: 24),
                _buildAccountGroup('Liabilities (2000 - 2999)', [
                  {
                    'code': '2010',
                    'name': 'Accounts Payable',
                    'balance': '\$ 185K',
                  },
                  {
                    'code': '2050',
                    'name': 'Accrued Taxes',
                    'balance': '\$ 32K',
                  },
                ]),
                const SizedBox(height: 24),
                _buildAccountGroup('Equity (3000 - 3999)', [
                  {
                    'code': '3010',
                    'name': 'Retained Earnings',
                    'balance': '\$ 850K',
                  },
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountGroup(String title, List<Map<String, String>> accounts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF64748B),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: accounts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final account = accounts[index];
              return ListTile(
                leading: Text(
                  account['code']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                title: Text(
                  account['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  account['balance']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
