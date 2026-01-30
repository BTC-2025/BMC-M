import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../config/app_colors.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      color: AppColors.background,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              isSmallScreen ? 16 : 24,
              20,
              isSmallScreen ? 16 : 24,
              120, // Space for bottom nav
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. The Core Value Card (Hero)
                _buildHeroCard(isSmallScreen),
                const SizedBox(height: 32),

                // 3. Performance Matrix
                _buildSectionHeader(
                  'Operational Pulse',
                  'Real-time performance metrics',
                ),
                const SizedBox(height: 16),
                _buildPerformanceGrid(isSmallScreen),
                const SizedBox(height: 32),

                // 4. Tactical Actions
                _buildSectionHeader(
                  'Tactical Actions',
                  'Immediate system commands',
                ),
                const SizedBox(height: 16),
                _buildQuickActions(isSmallScreen),
                const SizedBox(height: 32),

                // 5. Intelligence Feed (Alerts)
                _buildSectionHeader(
                  'Intelligence Feed',
                  'Critical system notifications',
                ),
                const SizedBox(height: 16),
                _buildAlertsList(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, const Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Iconsax.chart_square,
              size: 150,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Text(
                      'TOTAL REVENUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Icon(
                    Iconsax.more,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                '\$12,480.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF05CD99).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.arrow_up_3,
                          color: Color(0xFF05CD99),
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '+2.4%',
                          style: TextStyle(
                            color: Color(0xFF05CD99),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'vs last month',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildHeroMetric('Sales', '124', true),
                  const SizedBox(width: 40),
                  _buildHeroMetric('Leads', '42', true),
                  const SizedBox(width: 40),
                  _buildHeroMetric('Pipeline', '\$42k', true),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroMetric(String label, String value, bool isPositive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1B2559),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
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
        Icon(Iconsax.setting_4, size: 20, color: AppColors.textTertiary),
      ],
    );
  }

  Widget _buildPerformanceGrid(bool isSmallScreen) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(
          'Income',
          '\$8.4k',
          '+14%',
          Iconsax.wallet_money,
          const Color(0xFF05CD99),
        ),
        _buildStatCard(
          'Expenses',
          '\$2.1k',
          '-5%',
          Iconsax.empty_wallet_change,
          const Color(0xFFEE5D50),
        ),
        _buildStatCard(
          'Tasks',
          '84',
          'Active',
          Iconsax.task_square,
          const Color(0xFFFFB547),
        ),
        _buildStatCard(
          'Projects',
          '12',
          'Ongoing',
          Iconsax.folder_open,
          AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String trend,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (trend.isNotEmpty)
                Text(
                  trend,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: trend.startsWith('+')
                        ? const Color(0xFF05CD99)
                        : (trend.startsWith('-')
                              ? const Color(0xFFEE5D50)
                              : AppColors.textTertiary),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFA3AED0),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2559),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionItem('Invoice', Iconsax.receipt_21, AppColors.primary),
          _buildActionItem(
            'Add User',
            Iconsax.user_cirlce_add,
            const Color(0xFF4318FF),
          ),
          _buildActionItem('Scan', Iconsax.scan, const Color(0xFF05CD99)),
          _buildActionItem('More', Iconsax.category, const Color(0xFFFFB547)),
        ],
      ),
    );
  }

  Widget _buildActionItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertsList(bool isSmallScreen) {
    return Column(
      children: [
        _buildAlertTile(
          'Stock Warning',
          'Wireless Mouse is running low (5 items)',
          'Just now',
          Iconsax.warning_2,
          const Color(0xFFEE5D50),
        ),
        const SizedBox(height: 12),
        _buildAlertTile(
          'New Order',
          'Order #4221 from Tech Solutions',
          '3 New',
          Iconsax.shopping_cart,
          const Color(0xFF05CD99),
        ),
        const SizedBox(height: 12),
        _buildAlertTile(
          'System Update',
          'Version 2.4.0 is successfully installed',
          '1h ago',
          Iconsax.code,
          AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildAlertTile(
    String title,
    String sub,
    String time,
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
            color: const Color(0xFF7090B0).withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B2559),
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA3AED0),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7090B0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
