import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../config/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Business Intelligence',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2559),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Deep dive into your operational metrics.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 32),

              // 1. Revenue Overview Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7090B0).withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Iconsax.chart_2,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Flexible(
                                child: Text(
                                  'Revenue Analytics',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1B2559),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'This Year',
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
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBar(0.4),
                          _buildBar(0.6),
                          _buildBar(0.8),
                          _buildBar(0.5),
                          _buildBar(0.9, isActive: true),
                          _buildBar(0.7),
                          _buildBar(0.6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Mon',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Tue',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Wed',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Thu',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Fri',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Sat',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Sun',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Metrics Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  _buildMetricTile(
                    'Total Customers',
                    '2,543',
                    '+12%',
                    Iconsax.people,
                    const Color(0xFF4318FF),
                  ),
                  _buildMetricTile(
                    'Avg. Order Value',
                    '\$128.50',
                    '+2.4%',
                    Iconsax.shopping_cart,
                    const Color(0xFF05CD99),
                  ),
                  _buildMetricTile(
                    'Refund Rate',
                    '1.2%',
                    '-0.5%',
                    Iconsax.refresh,
                    AppColors.error,
                  ),
                  _buildMetricTile(
                    'Conversion',
                    '3.4%',
                    '+0.8%',
                    Iconsax.arrow_up_3,
                    AppColors.warning,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Category Distribution
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7090B0).withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category Distribution',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildCategoryRow(
                                'Electronics',
                                '45%',
                                const Color(0xFF4318FF),
                              ),
                              const SizedBox(height: 16),
                              _buildCategoryRow(
                                'Furniture',
                                '30%',
                                const Color(0xFF05CD99),
                              ),
                              const SizedBox(height: 16),
                              _buildCategoryRow(
                                'Clothing',
                                '25%',
                                const Color(0xFFFFB547),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: 0.75,
                            strokeWidth: 12,
                            backgroundColor: AppColors.background,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBar(double heightFactor, {bool isActive = false}) {
    return Container(
      width: 20,
      height: 160 * heightFactor,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildMetricTile(
    String title,
    String value,
    String trend,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7090B0).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: trend.startsWith('+')
                      ? const Color(0xFF05CD99)
                      : (trend.startsWith('-')
                            ? AppColors.error
                            : AppColors.textTertiary),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2559),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA3AED0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String name, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF1B2559),
            ),
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }
}
