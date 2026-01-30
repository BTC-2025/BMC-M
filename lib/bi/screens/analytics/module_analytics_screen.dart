import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class ModuleAnalyticsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ModuleAnalyticsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<ModuleAnalyticsScreen> createState() => _ModuleAnalyticsScreenState();
}

class _ModuleAnalyticsScreenState extends State<ModuleAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE), // Matches Inventory background
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'Module Analytics',
                subtitle: 'Deep dive into module ',
                showBackButton: true,
                onBack: widget.onBack,
                showMenuButton: true,
                onMenu: widget.onMenu,
              ),
            ),
            // Custom Tab Bar Container
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFFA3AED0),
                indicator: BoxDecoration(
                  color: const Color(0xFF4318FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.all(4),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: '  Inventory  '),
                  Tab(text: '  HRM  '),
                  Tab(text: '  Finance  '),
                  Tab(text: '  SCM  '),
                  Tab(text: '  Manufacturing  '),
                  Tab(text: '  Projects  '),
                  Tab(text: '  CRM  '),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAnalyticsContent('Inventory', Iconsax.box),
                  _buildAnalyticsContent('HRM', Iconsax.people),
                  _buildAnalyticsContent('Finance', Iconsax.wallet_money),
                  _buildAnalyticsContent('SCM', Iconsax.truck),
                  _buildAnalyticsContent('Manufacturing', Iconsax.setting_2),
                  _buildAnalyticsContent('Projects', Iconsax.task_square),
                  _buildAnalyticsContent('CRM', Iconsax.user_tag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsContent(String moduleName, IconData icon) {
    // Mock Data for Pie Chart
    final pieData = [
      {'name': 'Active', 'value': 60, 'color': const Color(0xFF4318FF)},
      {'name': 'Pending', 'value': 25, 'color': const Color(0xFF05CD99)},
      {'name': 'Closed', 'value': 15, 'color': const Color(0xFFEE5D50)},
    ];

    // Mock Data for Table
    final tableData = [
      {'id': '#001', 'name': 'Item A', 'status': 'Complete', 'value': '\$120'},
      {'id': '#002', 'name': 'Item B', 'status': 'Pending', 'value': '\$80'},
      {'id': '#003', 'name': 'Item C', 'status': 'Active', 'value': '\$200'},
      {'id': '#004', 'name': 'Item D', 'status': 'Active', 'value': '\$450'},
      {'id': '#005', 'name': 'Item E', 'status': 'Complete', 'value': '\$90'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Chart/Usage Card
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
                      children: [
                        Text(
                          '$moduleName Overview',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Performance Metrics',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Simulated Usage Chart
                Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: CustomPaint(
                    painter: _UsageChartPainter(),
                    size: Size.infinite,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Key Metrics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.15,
            children: [
              _buildStatCard(
                'Utilization',
                '85%',
                Icons.data_usage_rounded,
                const Color(0xFF4318FF),
                const Color(0xFFA0C4FF),
              ),
              _buildStatCard(
                'Active Users',
                '1.2k',
                Icons.people_alt_rounded,
                const Color(0xFF05CD99),
                const Color(0xFFC8E6C9),
              ),
              _buildStatCard(
                'Efficiency',
                'High',
                Icons.speed_rounded,
                const Color(0xFFFFB547),
                const Color(0xFFFFF9C4),
              ),
              _buildStatCard(
                'Issues',
                '12',
                Icons.warning_amber_rounded,
                const Color(0xFFEE5D50),
                const Color(0xFFFFCDD2),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPieChartSection(pieData),
          const SizedBox(height: 24),
          _buildDataTableSection(tableData),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPieChartSection(List<Map<String, dynamic>> data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          const Text(
            'Status Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 150,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _PieChartPainter(data),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: data.map<Widget>((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: item['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['name'],
                            style: const TextStyle(
                              color: Color(0xFFA3AED0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${item['value']}%',
                            style: const TextStyle(
                              color: Color(0xFF1B2559),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableSection(List<Map<String, dynamic>> data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Module Details',
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
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Color(0xFFA3AED0),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: 20,
              columns: const [
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: data.map((item) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        item['id'],
                        style: const TextStyle(
                          color: Color(0xFFA3AED0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item['name'],
                        style: const TextStyle(
                          color: Color(0xFF1B2559),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Icon(
                            item['status'] == 'Complete'
                                ? Icons.check_circle
                                : item['status'] == 'Pending'
                                ? Icons.pending
                                : Icons.play_circle_fill,
                            color: item['status'] == 'Complete'
                                ? const Color(0xFF05CD99)
                                : item['status'] == 'Pending'
                                ? const Color(0xFFFFB547)
                                : const Color(0xFF4318FF),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['status'],
                            style: TextStyle(
                              color: item['status'] == 'Complete'
                                  ? const Color(0xFF05CD99)
                                  : item['status'] == 'Pending'
                                  ? const Color(0xFFFFB547)
                                  : const Color(0xFF4318FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(
                        item['value'],
                        style: const TextStyle(
                          color: Color(0xFF1B2559),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
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
                  color: bgColor.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
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
                  overflow: TextOverflow.ellipsis,
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
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '+12% vs last month',
                  style: TextStyle(
                    color: Color(0xFF05CD99),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<dynamic> data;

  _PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -math.pi / 2;
    final double total = data
        .map((e) => e['value'] as int)
        .reduce((a, b) => a + b)
        .toDouble();

    // Draw Donut segments
    for (var item in data) {
      final double sweepAngle = (item['value'] / total) * 2 * math.pi;
      final paint = Paint()
        ..color = item['color']
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _UsageChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Simulate a curve
    final width = size.width;
    final height = size.height;

    path.moveTo(0, height * 0.7);
    path.cubicTo(
      width * 0.2,
      height * 0.8,
      width * 0.4,
      height * 0.4,
      width * 0.6,
      height * 0.6,
    );
    path.cubicTo(
      width * 0.8,
      height * 0.8,
      width * 0.9,
      height * 0.2,
      width,
      height * 0.4,
    );

    canvas.drawPath(path, paint);

    // Fill below
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.3),
          Colors.white.withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    final fillPath = Path.from(path);
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);

    // Draw dots
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(width * 0.6, height * 0.6), 4, dotPaint);
    canvas.drawCircle(Offset(width, height * 0.4), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
