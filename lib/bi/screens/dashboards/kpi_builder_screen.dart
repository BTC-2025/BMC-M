import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class KpiBuilderScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const KpiBuilderScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'KPI Builder',
                subtitle: 'Define custom performance metrics',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KPI Configuration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputSection(
                      'Metric Name',
                      'e.g., Net Profit Margin',
                      Iconsax.text,
                    ),
                    const SizedBox(height: 20),
                    _buildInputSection(
                      'Target Value',
                      'e.g., > 20%',
                      Iconsax.flag,
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Formula Builder',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFE0E5F2,
                            ).withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Formula Display
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F7FE),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFE0E5F2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'f(x) = ',
                                  style: TextStyle(
                                    color: Color(0xFFA3AED0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '( ',
                                        style: TextStyle(
                                          color: Color(0xFFA3AED0),
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Revenue',
                                        style: TextStyle(
                                          color: Color(0xFF4318FF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' - ',
                                        style: TextStyle(
                                          color: Color(0xFF1B2559),
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'COGS',
                                        style: TextStyle(
                                          color: Color(0xFF05CD99),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ) / ',
                                        style: TextStyle(
                                          color: Color(0xFFA3AED0),
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Revenue',
                                        style: TextStyle(
                                          color: Color(0xFF4318FF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Operators
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildOperatorBtn('+', Colors.orange),
                              _buildOperatorBtn('-', Colors.orange),
                              _buildOperatorBtn('×', Colors.orange),
                              _buildOperatorBtn('÷', Colors.orange),
                              _buildOperatorBtn('(', Colors.grey),
                              _buildOperatorBtn(')', Colors.grey),
                              _buildFunctionBtn('SUM'),
                              _buildFunctionBtn('AVG'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 12),

                          // Variables
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Available Metrics',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA3AED0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildVariableChip(
                                'Revenue',
                                const Color(0xFF4318FF),
                              ),
                              _buildVariableChip(
                                'COGS',
                                const Color(0xFF05CD99),
                              ),
                              _buildVariableChip(
                                'Expenses',
                                const Color(0xFFEE5D50),
                              ),
                              _buildVariableChip(
                                'Units Sold',
                                const Color(0xFFFFB547),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF4318FF),
        elevation: 10,
        icon: const Icon(Icons.save_rounded, color: Colors.white),
        label: const Text(
          'Save KPI',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInputSection(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B2559),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            style: const TextStyle(
              color: Color(0xFF1B2559),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              icon: Icon(icon, color: const Color(0xFF4318FF)),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFA3AED0),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOperatorBtn(String label, MaterialColor color) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color[700],
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionBtn(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1B2559),
        ),
      ),
    );
  }

  Widget _buildVariableChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
