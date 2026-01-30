import 'package:flutter/material.dart';

class EfficiencyStatsScreen extends StatelessWidget {
  const EfficiencyStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Efficiency Statistics',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OEE Hero Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2B3674), Color(0xFF0C1444)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2B3674).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Overall Equipment Effectiveness',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '82.5%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 4),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.speed_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOeeComponent(
                        'Availability',
                        '90%',
                        Colors.blue.shade300,
                      ),
                      _buildOeeComponent(
                        'Performance',
                        '95%',
                        Colors.green.shade300,
                      ),
                      _buildOeeComponent(
                        'Quality',
                        '98%',
                        Colors.orange.shade300,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Machine Performance',
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE0E5F2)),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Real-time',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4318FF),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.circle, color: Color(0xFF05CD99), size: 8),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Performance Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildMachineCard(
                  'CNC Machine #01',
                  'Running',
                  '92%',
                  85,
                  true,
                ),
                _buildMachineCard(
                  'Assembly Robot A',
                  'Running',
                  '98%',
                  92,
                  true,
                ),
                _buildMachineCard(
                  'Packaging Unit',
                  'Maintenance',
                  '0%',
                  0,
                  false,
                ),
                _buildMachineCard(
                  'Conveyor Belt 3',
                  'Running',
                  '88%',
                  78,
                  true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOeeComponent(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 3,
              height: 12,
              color: color,
              margin: const EdgeInsets.only(right: 6),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMachineCard(
    String name,
    String status,
    String efficiency,
    int load,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE3F2FD)
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isActive
                      ? Icons.precision_manufacturing_rounded
                      : Icons.warning_rounded,
                  color: isActive
                      ? const Color(0xFF1976D2)
                      : const Color(0xFFD32F2F),
                  size: 20,
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF05CD99)
                      : const Color(0xFFFFB547),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            status,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFF05CD99)
                  : const Color(0xFFFFB547),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Load',
                    style: TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
                  ),
                  Text(
                    '$load%',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: load / 100,
                backgroundColor: const Color(0xFFF4F7FE),
                color: isActive
                    ? const Color(0xFF4318FF)
                    : const Color(0xFFFFB547),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
