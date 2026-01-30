import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../widgets/inventory_header.dart';

class InventoryOverview extends StatefulWidget {
  const InventoryOverview({super.key});

  @override
  State<InventoryOverview> createState() => _InventoryOverviewState();
}

class _InventoryOverviewState extends State<InventoryOverview>
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Standardized Header
                InventoryHeader(
                  title: 'Inventory Mission',
                  subtitle: 'Stock & Asset Command Center',
                  showBackButton: true,
                  onBack: () => Navigator.of(context).pop(),
                  showMenuButton: true,
                  onMenu: () => Scaffold.of(context).openEndDrawer(),
                ),

                const SizedBox(height: 24),

                // Blue Gradient Hero Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4318FF), Color(0xFF5B30BA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4318FF).withValues(alpha: 0.3),
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
                                'Good morning! 👋',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Here\'s your business overview',
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
                              Icons.show_chart_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroMetric('Revenue', '\$ 0'),
                          _buildHeroMetric('Sales', '0'),
                          _buildHeroMetric('Customers', '0'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Overview',
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
                  childAspectRatio: 0.85,
                  children: [
                    _buildDetailedStatCard(
                      'Total Products',
                      '0',
                      Icons.inventory_2_outlined,
                      const Color(0xFFFF5252),
                      const Color(0xFFFFEBEE),
                    ),
                    _buildDetailedStatCard(
                      'Product Categories',
                      '0',
                      Icons.category_outlined,
                      const Color(0xFFFFA726),
                      const Color(0xFFFFF3E0),
                    ),
                    _buildDetailedStatCard(
                      'Total Sold',
                      '0',
                      Icons.shopping_cart_outlined,
                      const Color(0xFFFF5252),
                      const Color(0xFFFFEBEE),
                    ),
                    _buildDetailedStatCard(
                      'Monthly income',
                      '0.0k',
                      Icons.attach_money,
                      const Color(0xFFFFA726),
                      const Color(0xFFFFF3E0),
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
                        Icons.point_of_sale_rounded,
                        'New Sale',
                        const Color(0xFFE8F5E9),
                        const Color(0xFF4CAF50),
                      ),
                      _buildQuickActionItem(
                        Icons.person_add_alt_1_rounded,
                        'Add Customer',
                        const Color(0xFFF3E5F5),
                        const Color(0xFF9C27B0),
                      ),
                      _buildQuickActionItem(
                        Icons.bar_chart_rounded,
                        'Reports',
                        const Color(0xFFFFF3E0),
                        const Color(0xFFFFA726),
                      ),
                      _buildQuickActionItem(
                        Icons.inventory_2_rounded,
                        'Inventory',
                        const Color(0xFFE3F2FD),
                        const Color(0xFF2196F3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Analytics',
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
                        'Sales Trend',
                        Colors.blue,
                        child: CustomPaint(
                          size: const Size(150, 80),
                          painter: _LineChartPainter(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildAnalyticsCard(
                        'Stock Status',
                        Colors.indigo,
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
                                _buildLegendItem(Colors.green, 'Available'),
                                const SizedBox(height: 4),
                                _buildLegendItem(Colors.orange, 'Low Stock'),
                                const SizedBox(height: 4),
                                _buildLegendItem(Colors.red, 'Out of Stock'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Top Products Bar Chart
                Container(
                  padding: const EdgeInsets.all(24),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBarChartItem('iPhone', 100, Colors.blue),
                      _buildBarChartItem('MacBook', 80, Colors.blue),
                      _buildBarChartItem('AirPods', 60, Colors.blue),
                      _buildBarChartItem('iPad', 50, Colors.blue),
                      _buildBarChartItem('Watch', 30, Colors.blue),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Alerts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('View All')),
                  ],
                ),
                const SizedBox(height: 8),

                // Recent Alerts
                _buildAlertTile(
                  icon: Icons.warning_amber_rounded,
                  title: 'Low Stock Alert',
                  subtitle: 'iPhone 13 Pro - Only 2 left',
                  time: '2 hours ago',
                  iconColor: Colors.orange,
                  bgColor: Colors.orange.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 12),
                _buildAlertTile(
                  icon: Icons.info_outline_rounded,
                  title: 'New Order',
                  subtitle: 'Order #1234 - ₹299.99',
                  time: '1 hour ago',
                  iconColor: Colors.blue,
                  bgColor: Colors.blue.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 12),
                _buildAlertTile(
                  icon: Icons.error_outline_rounded,
                  title: 'Stock Expiry',
                  subtitle: 'Batch #B001 expires soon',
                  time: '30 min ago',
                  iconColor: Colors.red,
                  bgColor: Colors.red.withValues(alpha: 0.1),
                ),

                const SizedBox(height: 80), // Bottom matching padding
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
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
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
        borderRadius: BorderRadius.circular(24), // Unified corner radius
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
                    color: Color(0xFFA3AED0), // Secondary Text Color
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
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559), // Dark Blue
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
                      '15%',
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
          const Divider(),
          const Text(
            'Update: 10 Jan 2026',
            style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
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
            borderRadius: BorderRadius.circular(30), // Circle/Pill
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

  Widget _buildBarChartItem(String label, double height, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildAlertTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
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
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}

// Simple Custom Painters for Chart visualization
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.25, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.lineTo(size.width * 0.75, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.4);

    canvas.drawPath(path, paint);

    // Draw dots
    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, size.height * 0.8), 4, dotPaint);
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.5),
      4,
      dotPaint,
    );
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.7), 4, dotPaint);
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.2),
      4,
      dotPaint,
    );
    canvas.drawCircle(Offset(size.width, size.height * 0.4), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()..style = PaintingStyle.fill;

    // Segment 1: Green (65%)
    paint.color = Colors.green;
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * 0.65, true, paint);

    // Segment 2: Orange (25%)
    paint.color = Colors.orange;
    canvas.drawArc(
      rect,
      -math.pi / 2 + (2 * math.pi * 0.65),
      2 * math.pi * 0.25,
      true,
      paint,
    );

    // Segment 3: Red (10%)
    paint.color = Colors.red;
    canvas.drawArc(
      rect,
      -math.pi / 2 + (2 * math.pi * 0.90),
      2 * math.pi * 0.10,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
