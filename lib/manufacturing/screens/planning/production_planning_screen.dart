import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/production_plan.dart';
import '../../services/production_planning_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class ProductionPlanningScreen extends StatefulWidget {
  const ProductionPlanningScreen({super.key});

  @override
  State<ProductionPlanningScreen> createState() =>
      _ProductionPlanningScreenState();
}

class _ProductionPlanningScreenState extends State<ProductionPlanningScreen> {
  late Future<List<ProductionPlan>> _plansFuture;

  @override
  void initState() {
    super.initState();
    _plansFuture = ProductionPlanningService().getAllPlans();
  }

  void _onDrawerItemTapped(String screenName) {
    Navigator.pop(context);
  }

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
          'Production Planning',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: ManufacturingDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: 'Planning',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<ProductionPlan>>(
        future: _plansFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No plans found'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildPlanCard(snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(ProductionPlan plan) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    Color statusColor;
    Color statusBgColor;

    switch (plan.status) {
      case PlanStatus.draft:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withValues(alpha: 0.1);
        break;
      case PlanStatus.confirmed:
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withValues(alpha: 0.1);
        break;
      case PlanStatus.inProgress:
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1);
        break;
      case PlanStatus.completed:
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1);
        break;
    }

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    plan.status.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.date_range_rounded,
                  size: 16,
                  color: Color(0xFFA3AED0),
                ),
                const SizedBox(width: 6),
                Text(
                  '${dateFormat.format(plan.startDate)} - ${dateFormat.format(plan.endDate)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2B3674),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('Work Orders', '${plan.totalWorkOrders}'),
                _buildStat('Target Eff.', '${plan.targetEfficiency}%'),
                _buildStat('Owner', plan.createdBy.split(' ')[0]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }
}
