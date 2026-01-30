import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../config/app_colors.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Financial Console',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2559),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage cash flow and transactions.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 32),

              // 1. Balance Cards PageView (Horizontal Scroll)
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBalanceCard(
                      'Main Business Account',
                      '\$ 24,562.00',
                      '**** **** **** 4829',
                      [const Color(0xFF4318FF), const Color(0xFF5B30BA)],
                      true,
                    ),
                    const SizedBox(width: 16),
                    _buildBalanceCard(
                      'Operational Expense',
                      '\$ 4,120.50',
                      '**** **** **** 9921',
                      [const Color(0xFF05CD99), const Color(0xFF00BFA5)],
                      false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 2. Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(Iconsax.export_1, 'Transfer'),
                  _buildActionButton(Iconsax.import, 'Request'),
                  _buildActionButton(Iconsax.document_text, 'Invoices'),
                  _buildActionButton(Iconsax.more, 'More'),
                ],
              ),

              const SizedBox(height: 32),

              // 3. Financial Overview (Income vs Expense)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cash Flow',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F7FE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Weekly',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3AED0),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Color(0xFFA3AED0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFlowStat(
                            'Income',
                            '\$ 12,850',
                            Iconsax.arrow_circle_down,
                            const Color(0xFF05CD99),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE0E5F2),
                        ),
                        Expanded(
                          child: _buildFlowStat(
                            'Expense',
                            '\$ 4,200',
                            Iconsax.arrow_circle_up,
                            Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 4. Recent Transactions List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF4318FF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildTransactionTile(
                'Apple Store',
                'Electronics',
                '- \$850.00',
                DateTime.now(),
                Iconsax.mobile,
                Colors.black,
              ),
              const SizedBox(height: 16),
              _buildTransactionTile(
                'Client Payment',
                'Design Services',
                '+ \$2,500.00',
                DateTime.now().subtract(const Duration(hours: 4)),
                Iconsax.wallet_check,
                const Color(0xFF05CD99),
              ),
              const SizedBox(height: 16),
              _buildTransactionTile(
                'Office Supplies',
                'Stationery',
                '- \$120.50',
                DateTime.now().subtract(const Duration(days: 1)),
                Iconsax.edit_2,
                Colors.orange,
              ),

              const SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(
    String title,
    String balance,
    String cardNumber,
    List<Color> gradientColors,
    bool showPattern,
  ) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (showPattern)
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Iconsax.card,
                size: 150,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.nfc_rounded, color: Colors.white70),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                balance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF4318FF), size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowStat(
    String label,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFA3AED0),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(
    String title,
    String subtitle,
    String amount,
    DateTime date,
    IconData icon,
    Color iconBgColor,
  ) {
    final isNegative = amount.startsWith('-');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
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
              color: const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconBgColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isNegative ? Colors.redAccent : const Color(0xFF05CD99),
            ),
          ),
        ],
      ),
    );
  }
}
