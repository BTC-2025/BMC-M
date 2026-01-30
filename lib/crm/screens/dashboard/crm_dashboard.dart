import 'package:flutter/material.dart';
import '../../widgets/crm_header.dart';

class CrmDashboard extends StatefulWidget {
  const CrmDashboard({super.key});

  @override
  State<CrmDashboard> createState() => _CrmDashboardState();
}

class _CrmDashboardState extends State<CrmDashboard>
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
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrmHeader(
                  title: 'Sales Intelligence',
                  subtitle: 'CRM Overview & Pipeline Status',
                  showBackButton: true,
                  onBack: () => Navigator.of(context).pop(),
                  showMenuButton: true,
                ),

                const SizedBox(height: 24),

                // Gradient Hero Card
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
                                'Sales Pipeline 👋',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Track your leads and deals',
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
                              Icons.trending_up_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroMetric('Pipeline Value', '\$ 4.5M'),
                          _buildHeroMetric('Win Rate', '32%'),
                          _buildHeroMetric('Open Deals', '42'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Key Metrics',
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
                  childAspectRatio: 1.20,
                  children: [
                    _buildDetailedStatCard(
                      'Total Leads',
                      '128',
                      Icons.person_add_alt_1_outlined,
                      const Color(0xFF2979FF),
                      const Color(0xFFE3F2FD),
                    ),
                    _buildDetailedStatCard(
                      'New Customers',
                      '12',
                      Icons.verified_user_outlined,
                      const Color(0xFF00E676),
                      const Color(0xFFE8F5E9),
                    ),
                    _buildDetailedStatCard(
                      'Meetings',
                      '8',
                      Icons.calendar_month_outlined,
                      const Color(0xFFFF9100),
                      const Color(0xFFFFF3E0),
                    ),
                    _buildDetailedStatCard(
                      'Tasks Due',
                      '5',
                      Icons.task_alt,
                      const Color(0xFFFF1744),
                      const Color(0xFFFFEBEE),
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

                // Quick Actions
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
                        Icons.add_circle_outline_rounded,
                        'New Lead',
                        const Color(0xFFE3F2FD),
                        const Color(0xFF2196F3),
                      ),
                      _buildQuickActionItem(
                        Icons.phone_in_talk_rounded,
                        'Log Call',
                        const Color(0xFFF3E5F5),
                        const Color(0xFF9C27B0),
                      ),
                      _buildQuickActionItem(
                        Icons.email_outlined,
                        'Send Email',
                        const Color(0xFFFFF3E0),
                        const Color(0xFFFFA726),
                      ),
                      _buildQuickActionItem(
                        Icons.event_available_rounded,
                        'Schedule',
                        const Color(0xFFE8F5E9),
                        const Color(0xFF4CAF50),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Lead Sources',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),

                // Lead Sources Chart (Simplified)
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
                    children: [
                      // Simple Pie Chart Representation
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CustomPaint(painter: _PieChartPainter()),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          children: [
                            _buildLegendItem(
                              const Color(0xFF2979FF),
                              'Website (45%)',
                            ),
                            const SizedBox(height: 8),
                            _buildLegendItem(
                              const Color(0xFF00E676),
                              'Referral (30%)',
                            ),
                            const SizedBox(height: 8),
                            _buildLegendItem(
                              const Color(0xFFFF9100),
                              'Social Media (15%)',
                            ),
                            const SizedBox(height: 8),
                            _buildLegendItem(
                              Colors.grey.shade300,
                              'Others (10%)',
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
                      'Recent Activities',
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

                // Recent Activities List
                _buildActivityTile(
                  icon: Icons.phone_callback_rounded,
                  title: 'Call with Acme Corp',
                  subtitle: 'Discussed project requirements',
                  time: '10 min ago',
                  iconColor: Colors.blue,
                  bgColor: Colors.blue.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 12),
                _buildActivityTile(
                  icon: Icons.mail_outline_rounded,
                  title: 'Email sent to John Doe',
                  subtitle: 'Follow-up on proposal #402',
                  time: '2 hours ago',
                  iconColor: Colors.purple,
                  bgColor: Colors.purple.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 12),
                _buildActivityTile(
                  icon: Icons.check_circle_outline_rounded,
                  title: 'Task Completed',
                  subtitle: 'Prepare Q1 presentation',
                  time: 'Yesterday',
                  iconColor: Colors.green,
                  bgColor: Colors.green.withValues(alpha: 0.1),
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
                    fontSize: 13,
                  ),
                  maxLines: 2,
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
                  fontSize: 24,
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
                      '12%',
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

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTile({
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

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    // Segment 1
    paint.color = const Color(0xFF2979FF);
    canvas.drawArc(rect, 0, 3.14 * 0.9, false, paint);

    // Segment 2
    paint.color = const Color(0xFF00E676);
    canvas.drawArc(rect, 3.14 * 0.9 + 0.2, 3.14 * 0.6, false, paint);

    // Segment 3
    paint.color = const Color(0xFFFF9100); // Orange
    canvas.drawArc(
      rect,
      3.14 * 0.9 + 0.2 + 3.14 * 0.6 + 0.2,
      3.14 * 0.3,
      false,
      paint,
    );

    // Segment 4
    paint.color = Colors.grey.shade300;
    canvas.drawArc(
      rect,
      3.14 * 0.9 + 0.2 + 3.14 * 0.6 + 0.2 + 3.14 * 0.3 + 0.2,
      0.4,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
