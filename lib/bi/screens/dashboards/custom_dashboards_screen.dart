import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';
import 'create_dashboard_screen.dart';

class CustomDashboardsScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const CustomDashboardsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateDashboardScreen(onBack: () => Navigator.pop(context)),
            ),
          );
        },
        backgroundColor: const Color(0xFF4318FF),
        elevation: 10,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'Create Dashboard',
                subtitle: 'Customize your analytics workspace',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saved Dashboards Scroller
                    const Text(
                      'My Dashboards',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildDashboardPreviewCard(
                            'Sales Overview',
                            Iconsax.chart_1,
                            const Color(0xFF4318FF),
                            true,
                          ),
                          const SizedBox(width: 16),
                          _buildDashboardPreviewCard(
                            'HR Metrics',
                            Iconsax.people,
                            const Color(0xFF05CD99),
                            false,
                          ),
                          const SizedBox(width: 16),
                          _buildDashboardPreviewCard(
                            'Financials',
                            Iconsax.wallet_money,
                            const Color(0xFFFFB547),
                            false,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'Dashboard Builder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Drag widgets to canvas to add them',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFA3AED0).withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Builder Canvas Area
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFE0E5F2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFE0E5F2,
                            ).withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Mock Canvas Grid
                          AspectRatio(
                            aspectRatio: 1.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F7FE),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(
                                    0xFFA3AED0,
                                  ).withValues(alpha: 0.2),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Grid lines mock
                                  Column(
                                    children: List.generate(
                                      4,
                                      (index) => Expanded(
                                        child: Divider(
                                          color: const Color(
                                            0xFFA3AED0,
                                          ).withValues(alpha: 0.1),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      4,
                                      (index) => Expanded(
                                        child: VerticalDivider(
                                          color: const Color(
                                            0xFFA3AED0,
                                          ).withValues(alpha: 0.1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Mock Placed Widget
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: _buildPlacedWidgetMock(
                                      'Revenue Chart',
                                      Iconsax.chart,
                                      const Color(0xFF4318FF),
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: _buildPlacedWidgetMock(
                                      'Users',
                                      Iconsax.people,
                                      const Color(0xFF05CD99),
                                    ),
                                  ),

                                  const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Iconsax.add,
                                          color: Color(0xFFA3AED0),
                                          size: 32,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Drop widgets here',
                                          style: TextStyle(
                                            color: Color(0xFFA3AED0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Divider(color: Color(0xFFE0E5F2)),
                          const SizedBox(height: 16),

                          // Available Widgets
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Available Widgets',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B2559),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildDraggableChip('KPI Card', Iconsax.card),
                              _buildDraggableChip('Line Chart', Iconsax.graph),
                              _buildDraggableChip(
                                'Bar Graph',
                                Iconsax.chart_21,
                              ),
                              _buildDraggableChip('Pie Chart', Iconsax.chart_1),
                              _buildDraggableChip('Table', Iconsax.grid_1),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardPreviewCard(
    String title,
    IconData icon,
    Color color,
    bool isActive,
  ) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? color : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isActive
                ? color.withValues(alpha: 0.4)
                : const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.2)
                  : color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: isActive ? Colors.white : color, size: 20),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF1B2559),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '4 Widgets',
            style: TextStyle(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.8)
                  : const Color(0xFFA3AED0),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacedWidgetMock(String label, IconData icon, Color color) {
    return Container(
      width: 100,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE0E5F2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF4318FF), size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1B2559),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
