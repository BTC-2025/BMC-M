import 'package:flutter/material.dart';

class ScmReportsScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ScmReportsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFEF6C00),
            size: 20,
          ),
          onPressed: onBack,
        ),
        title: const Text(
          'Logistics Reports',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFFEF6C00)),
            onPressed: onMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 16),
            _buildMetricGrid(),
            const SizedBox(height: 24),
            _buildVolumeChart('Monthly Procurement Volume'),
            const SizedBox(height: 16),
            _buildRatingChart('Supplier Rating Distribution'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildMiniMetric('On-Time Delivery', '94.2%', Colors.green),
        _buildMiniMetric('Total Procurement', '\$1.2M', Colors.blue),
        _buildMiniMetric('Active Suppliers', '24', Colors.orange),
        _buildMiniMetric('Avg Lead Time', '5.2 Days', Colors.purple),
      ],
    );
  }

  Widget _buildMiniMetric(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeChart(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.4, 'Jan'),
                _buildBar(0.6, 'Feb'),
                _buildBar(0.8, 'Mar'),
                _buildBar(0.5, 'Apr'),
                _buildBar(0.7, 'May'),
                _buildBar(0.9, 'Jun'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 150 * heightFactor,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFA3AED0),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingChart(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CustomPaint(painter: _PieChartPainter()),
              ),
              const SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(const Color(0xFF05CD99), 'Excellent (65%)'),
                  const SizedBox(height: 10),
                  _buildLegendItem(const Color(0xFFFFB547), 'Good (25%)'),
                  const SizedBox(height: 10),
                  _buildLegendItem(const Color(0xFFEE5D50), 'Poor (10%)'),
                ],
              ),
            ],
          ),
        ],
      ),
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
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF707EAE),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..style = PaintingStyle.fill;

    // Excellent
    paint.color = const Color(0xFF05CD99);
    canvas.drawArc(rect, -1.57, 4.08, true, paint); // ~65%

    // Good
    paint.color = const Color(0xFFFFB547);
    canvas.drawArc(rect, 2.51, 1.57, true, paint); // ~25%

    // Poor
    paint.color = const Color(0xFFEE5D50);
    canvas.drawArc(rect, 4.08, 0.63, true, paint); // ~10%

    // Hole for Donut
    paint.color = Colors.white;
    canvas.drawCircle(center, radius * 0.6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
