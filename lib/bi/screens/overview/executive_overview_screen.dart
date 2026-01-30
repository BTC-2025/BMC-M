import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../config/app_colors.dart';
import '../../../inventory/widgets/inventory_header.dart';
import '../../bloc/executive_overview_bloc.dart';
import '../../repositories/bi_repository.dart';

class ExecutiveOverviewScreen extends StatelessWidget {
  final VoidCallback onMenu;

  const ExecutiveOverviewScreen({super.key, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BiRepository(),
      child: BlocProvider(
        create: (context) =>
            ExecutiveOverviewBloc(repository: context.read<BiRepository>())
              ..add(LoadOverviewData()),
        child: _ExecutiveOverviewView(onMenu: onMenu),
      ),
    );
  }
}

class _ExecutiveOverviewView extends StatelessWidget {
  final VoidCallback onMenu;

  const _ExecutiveOverviewView({required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<ExecutiveOverviewBloc, ExecutiveOverviewState>(
          builder: (context, state) {
            if (state is ExecutiveOverviewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExecutiveOverviewError) {
              return Center(child: Text(state.message));
            } else if (state is ExecutiveOverviewLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: InventoryHeader(
                        title: 'Executive Overview',
                        subtitle: 'Business Intelligence Dashboard',
                        showBackButton: true,
                        showMenuButton: true,
                        onMenu: onMenu,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderValues(state.kpis),
                          const SizedBox(height: 24),
                          _buildTopProductsTable(state.tableData),
                          const SizedBox(height: 24),
                          _buildChartsSection(state.charts),
                          const SizedBox(height: 24),
                          _buildInsightsList(state.insights),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeaderValues(List<Map<String, dynamic>> kpis) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: kpis.length,
      itemBuilder: (context, index) {
        final kpi = kpis[index];
        return _buildKpiCard(
          kpi['title'],
          kpi['value'],
          kpi['subtitle'],
          kpi['color'],
          kpi['icon'],
        );
      },
    );
  }

  Widget _buildKpiCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Icon(Iconsax.more, color: Color(0xFFA3AED0), size: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA3AED0),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: subtitle.contains('-') || subtitle.contains('down')
                      ? const Color(0xFFEE5D50)
                      : const Color(0xFF05CD99),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(Map<String, dynamic> charts) {
    return Column(
      children: [
        // Sales Trend
        _buildSalesTrendChart(charts['sales_trend']),
        const SizedBox(height: 16),
        // Revenue vs Expense
        _buildRevenueExpenseChart(charts['revenue_vs_expenses']),
        const SizedBox(height: 16),
        // Category Distribution
        _buildCategoryDistribution(charts['category_distribution']),
      ],
    );
  }

  Widget _buildSalesTrendChart(List<dynamic> trendData) {
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
            'Sales Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: CustomPaint(
              size: Size.infinite,
              painter: _SalesTrendPainter(trendData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueExpenseChart(List<dynamic> data) {
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
            'Rev vs Exp',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data
                  .map<Widget>(
                    (heightFactor) => _buildBar(
                      heightFactor.toDouble(),
                      heightFactor > 0.6
                          ? const Color(0xFF4318FF)
                          : const Color(0xFFEE5D50),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDistribution(List<dynamic> data) {
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
            'Category Distribution',
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

  Widget _buildTopProductsTable(List<Map<String, dynamic>> products) {
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
                'Top Products',
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
                    'Name',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Category',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Price',
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
              ],
              rows: products.map((product) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        product['name'],
                        style: const TextStyle(
                          color: Color(0xFF1B2559),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(Text(product['category'])),
                    DataCell(Text(product['price'])),
                    DataCell(
                      Row(
                        children: [
                          Icon(
                            product['status'] == 'In Stock'
                                ? Icons.check_circle
                                : product['status'] == 'Low Stock'
                                ? Icons.warning
                                : Icons.cancel,
                            color: product['status'] == 'In Stock'
                                ? const Color(0xFF05CD99)
                                : product['status'] == 'Low Stock'
                                ? const Color(0xFFFFB547)
                                : const Color(0xFFEE5D50),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product['status'],
                            style: TextStyle(
                              color: product['status'] == 'In Stock'
                                  ? const Color(0xFF05CD99)
                                  : product['status'] == 'Low Stock'
                                  ? const Color(0xFFFFB547)
                                  : const Color(0xFFEE5D50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  Widget _buildBar(double heightFactor, Color color) {
    return Container(
      width: 24,
      height: 180 * heightFactor,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildInsightsList(List<Map<String, dynamic>> insights) {
    return Column(
      children: insights
          .map(
            (insight) => _buildInsightItem(
              insight['title'],
              insight['description'],
              insight['icon'],
              insight['color'],
            ),
          )
          .toList(),
    );
  }

  Widget _buildInsightItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFFA3AED0)),
        ],
      ),
    );
  }
}

class _SalesTrendPainter extends CustomPainter {
  final List<dynamic> data;

  _SalesTrendPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFF4318FF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double stepX = size.width / (data.length - 1);
    final double maxY = data
        .map((e) => e['value'] as int)
        .reduce(math.max)
        .toDouble();
    final double minY = data
        .map((e) => e['value'] as int)
        .reduce(math.min)
        .toDouble();
    final double rangeY = maxY - minY;

    // Move to first point
    double firstY =
        size.height -
        ((data[0]['value'] - minY) / rangeY) * size.height * 0.8 -
        size.height * 0.1;
    path.moveTo(0, firstY);

    for (int i = 1; i < data.length; i++) {
      double x = stepX * i;
      double y =
          size.height -
          ((data[i]['value'] - minY) / rangeY) * size.height * 0.8 -
          size.height * 0.1;

      // Simple linear interpolation
      path.lineTo(x, y);
    }

    // Shadow Gradient
    final shadowPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final shadowPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF4318FF).withValues(alpha: 0.2),
          const Color(0xFF4318FF).withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);

    // Draw dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final dotBorderPaint = Paint()
      ..color = const Color(0xFF4318FF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < data.length; i++) {
      double x = stepX * i;
      double y =
          size.height -
          ((data[i]['value'] - minY) / rangeY) * size.height * 0.8 -
          size.height * 0.1;

      canvas.drawCircle(Offset(x, y), 5, dotPaint);
      canvas.drawCircle(Offset(x, y), 5, dotBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
