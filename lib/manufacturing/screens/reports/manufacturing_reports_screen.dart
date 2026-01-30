import 'package:flutter/material.dart';
import '../../widgets/manufacturing_drawer.dart';

class ManufacturingReportsScreen extends StatelessWidget {
  const ManufacturingReportsScreen({super.key});

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
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Production Analytics',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      endDrawer: ManufacturingDrawer(
        onItemTapped: (name) => Navigator.pop(context),
        selectedItem: 'Production Reports',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPerformanceGrid(),
            const SizedBox(height: 32),
            const Text(
              'Key Performance Indicators',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 16),
            _buildReportTiles(),
            const SizedBox(height: 32),
            _buildChartPlaceholder('Monthly Production Output'),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(
          'Plan Adherence',
          '94%',
          Icons.trending_up,
          Colors.green,
        ),
        _buildStatCard(
          'Machine Util',
          '82%',
          Icons.settings_rounded,
          Colors.blue,
        ),
        _buildStatCard(
          'Waste Rate',
          '2.4%',
          Icons.delete_outline_rounded,
          Colors.orange,
        ),
        _buildStatCard(
          'Labor Cost / Unit',
          '\$12.5',
          Icons.people_outline,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA3AED0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportTiles() {
    return Column(
      children: [
        _buildReportTile(
          'Material Consumption Analysis',
          'Detailed report on BOM vs Actual usage',
          Icons.inventory_2_outlined,
        ),
        _buildReportTile(
          'Cost Variance Summary',
          'Price and quantity variance across orders',
          Icons.savings_outlined,
        ),
        _buildReportTile(
          'Quality Inspection Log',
          'Pass/Fail trends and defect categorization',
          Icons.verified_user_outlined,
        ),
        _buildReportTile(
          'Work Order Efficiency',
          'Throughput and cycle time by production line',
          Icons.speed_rounded,
        ),
      ],
    );
  }

  Widget _buildReportTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFA3AED0),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildChartPlaceholder(String title) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Text(
                      'This Month',
                      style: TextStyle(
                        color: Color(0xFFA3AED0),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Color(0xFFA3AED0)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.4, 'Week 1'),
                _buildBar(0.6, 'Week 2'),
                _buildBar(0.8, 'Week 3'),
                _buildBar(0.5, 'Week 4'),
                _buildBar(0.7, 'Week 5'),
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
          width: 30,
          height: 150 * heightFactor,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFA3AED0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
