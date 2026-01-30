import 'package:flutter/material.dart';

import '../../widgets/manufacturing_header.dart';

class ManufacturingDashboardScreen extends StatefulWidget {
  const ManufacturingDashboardScreen({super.key});

  @override
  State<ManufacturingDashboardScreen> createState() =>
      _ManufacturingDashboardScreenState();
}

class _ManufacturingDashboardScreenState
    extends State<ManufacturingDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(position: _slideAnimation, child: child),
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ManufacturingHeader(
                  title: 'Production Overview',
                  subtitle: 'Shop Floor & Efficiency',
                  showBackButton: true,
                  onBack: () => Navigator.of(context).pop(),
                  showMenuButton: true,
                  onMenu: () => Scaffold.of(context).openEndDrawer(),
                ),
                const SizedBox(height: 24),

                // Orange Gradient Hero Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9100), Color(0xFFFF6D00)], // Orange
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF9100).withValues(alpha: 0.3),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Factory Status 🏭',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Line A & B Operating Normally',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.precision_manufacturing_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroMetric('Active Jobs', '14'),
                          _buildHeroMetric('Efficiency', '92%'),
                          _buildHeroMetric('Output', '1.2k'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'KPIs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),

                // Detailed Stats Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.25,
                  children: [
                    _buildDetailedStatCard(
                      'Defect Rate',
                      '0.4%',
                      Icons.warning_amber_rounded,
                      const Color(0xFFD32F2F),
                      const Color(0xFFFFEBEE),
                    ),
                    _buildDetailedStatCard(
                      'Machine Uptime',
                      '98%',
                      Icons.settings_power_rounded,
                      const Color(0xFF2E7D32),
                      const Color(0xFFE8F5E9),
                    ),
                    _buildDetailedStatCard(
                      'WIP Inventory',
                      '420',
                      Icons.layers_rounded,
                      const Color(0xFF1565C0),
                      const Color(0xFFE3F2FD),
                    ),
                    _buildDetailedStatCard(
                      'Cycle Time',
                      '45m',
                      Icons.timer_rounded,
                      const Color(0xFFF9A825),
                      const Color(0xFFFFFDE7),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),

                // Rounded Quick Actions
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickActionItem(
                        Icons.add_task_rounded,
                        'New Order',
                        const Color(0xFFE3F2FD),
                        const Color(0xFF2196F3),
                      ),
                      _buildQuickActionItem(
                        Icons.build_rounded,
                        'Maintenance',
                        const Color(0xFFFFEBEE),
                        const Color(0xFFFF5252),
                      ),
                      _buildQuickActionItem(
                        Icons.fact_check_rounded,
                        'Quality Check',
                        const Color(0xFFE8F5E9),
                        const Color(0xFF4CAF50),
                      ),
                      _buildQuickActionItem(
                        Icons.calendar_month_rounded,
                        'Planning',
                        const Color(0xFFF3E5F5),
                        const Color(0xFF9C27B0),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Production Trends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),

                // Analytics Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildAnalyticsCard(
                        'Weekly Output',
                        const Color(0xFFFF6D00),
                        child: CustomPaint(
                          size: const Size(150, 80),
                          painter: _LineChartPainter(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildAnalyticsCard(
                        'Resource Usage',
                        const Color(0xFF1565C0),
                        child: Row(
                          children: [
                            CustomPaint(
                              size: const Size(80, 80),
                              painter: _PieChartPainter(),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegendItem(
                                  const Color(0xFF1565C0),
                                  'Raw Mat.',
                                ),
                                const SizedBox(height: 4),
                                _buildLegendItem(
                                  const Color(0xFFFF6D00),
                                  'Labor',
                                ),
                                const SizedBox(height: 4),
                                _buildLegendItem(
                                  const Color(0xFF9E9E9E),
                                  'Overhead',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildDetailedStatCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
    Color iconBgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFA3AED0),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_drop_up,
                      color: Color(0xFF43A047),
                      size: 16,
                    ),
                    Text(
                      '2%',
                      style: TextStyle(
                        color: Color(0xFF43A047),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    Color iconColor, {
    required Widget child,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.show_chart_rounded,
                  color: iconColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6D00)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.6);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = const Color(0xFF1565C0);
    canvas.drawArc(rect, 0, 3.14 * 1.2, true, paint);

    paint.color = const Color(0xFFFF6D00);
    canvas.drawArc(rect, 3.14 * 1.2, 3.14 * 0.6, true, paint);

    paint.color = const Color(0xFF9E9E9E);
    canvas.drawArc(rect, 3.14 * 1.8, 3.14 * 0.2, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
