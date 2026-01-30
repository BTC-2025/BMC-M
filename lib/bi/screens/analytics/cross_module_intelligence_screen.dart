import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class CrossModuleIntelligenceScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const CrossModuleIntelligenceScreen({
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
                title: 'Cross-Module Intelligence',
                subtitle: 'AI-driven insights across ecosystem',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Network Graph Card
                    Container(
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
                            color: const Color(
                              0xFF4318FF,
                            ).withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Correlation Network',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Visualizing impact dependencies',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: CustomPaint(painter: _NetworkGraphPainter()),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'AI Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildInsightCard(
                      'Sales ↔ Inventory',
                      'High demand for "Wireless Mouse" correlates with low stock alerts in "Warehouse A".',
                      'Recommendation: Increase reorder verification for fast-moving electronics.',
                      Iconsax.box,
                      Iconsax.shop,
                      const Color(0xFF4318FF),
                    ),
                    const SizedBox(height: 16),
                    _buildInsightCard(
                      'Payroll ↔ Project Profitability',
                      'Overtime costs in "Development Team" are reducing profit margins on "Project Alpha".',
                      'Recommendation: Review resource allocation or adjust project timelines.',
                      Iconsax.money_send,
                      Iconsax.task_square,
                      const Color(0xFFEE5D50),
                    ),
                    const SizedBox(height: 16),
                    _buildInsightCard(
                      'Manufacturing ↔ SCM',
                      'Delay in "Raw Material B" shipments is causing 15% downtime in "Production Line 2".',
                      'Recommendation: Source alternative supplier for "Raw Material B".',
                      Iconsax.setting_2,
                      Iconsax.truck,
                      const Color(0xFFFFB547),
                    ),
                    const SizedBox(height: 16),
                    _buildInsightCard(
                      'CRM ↔ Revenue',
                      'Leads from "Summer Campaign" have a 25% higher conversion rate.',
                      'Recommendation: Allocate more budget to similar marketing campaigns.',
                      Iconsax.user_tag,
                      Iconsax.wallet_money,
                      const Color(0xFF05CD99),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(
    String title,
    String observation,
    String recommendation,
    IconData icon1,
    IconData icon2,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon1, color: color, size: 24),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Iconsax.arrow_right_1, color: Color(0xFFA3AED0)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon2, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Observation',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA3AED0).withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            observation,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1B2559),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E5F2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Iconsax.lamp_on, color: Color(0xFF4318FF), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Recommendation',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4318FF),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recommendation.replaceFirst('Recommendation: ', ''),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1B2559),
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;

    // Nodes: Label, Angle
    final nodes = [
      {'label': 'Sales', 'angle': 0.0},
      {'label': 'Inv.', 'angle': math.pi / 3},
      {'label': 'SCM', 'angle': 2 * math.pi / 3},
      {'label': 'Mfg.', 'angle': math.pi},
      {'label': 'HR', 'angle': 4 * math.pi / 3},
      {'label': 'Fin.', 'angle': 5 * math.pi / 3},
    ];

    List<Offset> points = [];

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw Connections first
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final strongLinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Calculate positions
    for (var node in nodes) {
      final angle = node['angle'] as double;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      points.add(Offset(x, y));
    }

    // Fully connected graph (mesh)
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        // Randomly decide correlation strength for visualization
        bool strong =
            (i == 0 && j == 1) || (i == 3 && j == 2) || (i == 0 && j == 5);
        canvas.drawLine(
          points[i],
          points[j],
          strong ? strongLinePaint : linePaint,
        );
      }
    }

    // Draw Nodes and Labels
    final nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final label = nodes[i]['label'] as String;

      // Glow effect
      canvas.drawCircle(
        point,
        8,
        Paint()..color = Colors.white.withValues(alpha: 0.3),
      );

      canvas.drawCircle(point, 4, nodePaint);

      // Label
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();

      // Offset label based on position relative to center
      double offsetX = 0;
      double offsetY = 0;
      if (point.dx > center.dx) offsetX = 10;
      if (point.dx < center.dx) offsetX = -textPainter.width - 10;
      if (point.dy > center.dy) offsetY = 10;
      if (point.dy < center.dy) offsetY = -textPainter.height - 10;

      textPainter.paint(canvas, point + Offset(offsetX, offsetY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
