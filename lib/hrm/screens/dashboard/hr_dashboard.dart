import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../widgets/hrm_header.dart';

class HrDashboard extends StatefulWidget {
  const HrDashboard({super.key});

  @override
  State<HrDashboard> createState() => _HrDashboardState();
}

class _HrDashboardState extends State<HrDashboard>
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
      color: const Color(0xFFF4F7FE), // Pale Blue Background
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
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HrmHeader(
                  title: 'HRM Mission',
                  subtitle: 'Human Capital HQ',
                  onBack: () => Navigator.pop(context),
                ),

                const SizedBox(height: 24),

                // Purple Gradient Hero Card
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
                        color: const Color(0xFF4776E6).withValues(alpha: 0.3),
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
                                'People First 🤝',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your workforce at a glance',
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
                              Icons.groups_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroMetric('Staff', '248'),
                          _buildHeroMetric('On Leave', '12'),
                          _buildHeroMetric('Open Jobs', '5'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'People Analytics',
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
                      'Total Employees',
                      '248',
                      Icons.people_outline,
                      const Color(0xFF4776E6),
                      const Color(0xFFEEF2FF),
                    ),
                    _buildDetailedStatCard(
                      'New Hires',
                      '12',
                      Icons.person_add_outlined,
                      const Color(0xFF8E54E9),
                      const Color(0xFFF5EEFF),
                    ),
                    _buildDetailedStatCard(
                      'Present Ratio',
                      '94%',
                      Icons.how_to_reg_outlined,
                      const Color(0xFF10B981),
                      const Color(0xFFECFDF5),
                    ),
                    _buildDetailedStatCard(
                      'Payroll Disb.',
                      '98%',
                      Icons.payments_outlined,
                      const Color(0xFFF59E0B),
                      const Color(0xFFFFFBEB),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                const Text(
                  'Quick HR Actions',
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
                        Icons.check_circle_rounded,
                        'Attendance',
                        const Color(0xFFE8F5E9),
                        const Color(0xFF4CAF50),
                      ),
                      _buildQuickActionItem(
                        Icons.person_add_rounded,
                        'Add Staff',
                        const Color(0xFFF3E5F5),
                        const Color(0xFF9C27B0),
                      ),
                      _buildQuickActionItem(
                        Icons.assignment_ind_rounded,
                        'Recruit',
                        const Color(0xFFFFF3E0),
                        const Color(0xFFFFA726),
                      ),
                      _buildQuickActionItem(
                        Icons.account_balance_wallet_rounded,
                        'Payroll',
                        const Color(0xFFE3F2FD),
                        const Color(0xFF2196F3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Trends',
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
                        'Hiring Growth',
                        const Color(0xFF4776E6),
                        child: CustomPaint(
                          size: const Size(150, 80),
                          painter: _LineChartPainter(
                            color: const Color(0xFF4776E6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildAnalyticsCard(
                        'Employee Satisfaction',
                        const Color(0xFF8E54E9),
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
                                  const Color(0xFF10B981),
                                  'Satisfied',
                                ),
                                const SizedBox(height: 4),
                                _buildLegendItem(
                                  const Color(0xFFF59E0B),
                                  'Neutral',
                                ),
                                const SizedBox(height: 4),
                                _buildLegendItem(
                                  const Color(0xFFEF4444),
                                  'Unsatisfied',
                                ),
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
                      'Top Departments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4776E6).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.business_rounded,
                        color: Color(0xFF4776E6),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Top Departments Bar Chart
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
                      _buildBarChartItem('IT', 100, const Color(0xFF4776E6)),
                      _buildBarChartItem('Sales', 80, const Color(0xFF4776E6)),
                      _buildBarChartItem('HR', 40, const Color(0xFF4776E6)),
                      _buildBarChartItem('Admin', 50, const Color(0xFF4776E6)),
                      _buildBarChartItem(
                        'Support',
                        60,
                        const Color(0xFF4776E6),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today\'s Alerts',
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
                  icon: Icons.event_note_rounded,
                  title: 'New Leave Request',
                  subtitle: 'Alice Smith requested 3 days off',
                  time: '15 min ago',
                  iconColor: const Color(0xFFF59E0B),
                  bgColor: const Color(0xFFFFFBEB),
                ),
                const SizedBox(height: 12),
                _buildAlertTile(
                  icon: Icons.person_search_rounded,
                  title: 'Candidate Applied',
                  subtitle: 'Java Developer position - 12 new',
                  time: '1 hour ago',
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                ),
                const SizedBox(height: 12),
                _buildAlertTile(
                  icon: Icons.error_outline_rounded,
                  title: 'Contract Expiring',
                  subtitle: 'Bob Martin\'s contract ends soon',
                  time: '2 hours ago',
                  iconColor: const Color(0xFFEF4444),
                  bgColor: const Color(0xFFFEF2F2),
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
            fontSize: 22,
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
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
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
          const Divider(),
          const Text(
            'Refreshed: Just now',
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
                  fontSize: 15,
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
          width: 35,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.bold,
          ),
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

class _LineChartPainter extends CustomPainter {
  final Color color;
  _LineChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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

    final dotPaint = Paint()
      ..color = color
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

    // Segment 1: Green (75%)
    paint.color = const Color(0xFF10B981);
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * 0.75, true, paint);

    // Segment 2: Orange (15%)
    paint.color = const Color(0xFFF59E0B);
    canvas.drawArc(
      rect,
      -math.pi / 2 + (2 * math.pi * 0.75),
      2 * math.pi * 0.15,
      true,
      paint,
    );

    // Segment 3: Red (10%)
    paint.color = const Color(0xFFEF4444);
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
