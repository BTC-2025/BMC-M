import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/production_cost.dart';
import '../../services/production_costing_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class ProductionCostingScreen extends StatefulWidget {
  const ProductionCostingScreen({super.key});

  @override
  State<ProductionCostingScreen> createState() =>
      _ProductionCostingScreenState();
}

class _ProductionCostingScreenState extends State<ProductionCostingScreen> {
  late Future<List<ProductionCost>> _costsFuture;

  @override
  void initState() {
    super.initState();
    _costsFuture = ProductionCostingService().getCostReports();
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
          'Production Costing',
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
        selectedItem: 'Production Costing',
      ),
      body: FutureBuilder<List<ProductionCost>>(
        future: _costsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cost reports available'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildCostCard(snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildCostCard(ProductionCost cost) {
    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final bool isPositiveVariance = cost.variance > 0;

    return Container(
      padding: const EdgeInsets.all(20),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cost.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cost.workOrderId,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currency.format(cost.totalCost),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Actual Total',
                    style: TextStyle(fontSize: 10, color: Color(0xFFA3AED0)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCostSummary(
                'Planned',
                currency.format(cost.plannedCost),
                Colors.grey,
              ),
              _buildCostSummary(
                'Variance',
                '${isPositiveVariance ? '+' : ''}${currency.format(cost.variance)}',
                isPositiveVariance ? Colors.redAccent : Colors.green,
              ),
              _buildCostSummary(
                'Variance %',
                '${isPositiveVariance ? '+' : ''}${cost.variancePercentage.toStringAsFixed(1)}%',
                isPositiveVariance ? Colors.redAccent : Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCostItem('Material', cost.materialCost),
              _buildCostItem('Labor', cost.laborCost),
              _buildCostItem('Overhead', cost.overheadCost),
              _buildCostItem('Wastage', cost.wastageCost, isWarning: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFFA3AED0),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCostItem(String label, double amount, {bool isWarning = false}) {
    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
        ),
        const SizedBox(height: 4),
        Text(
          currency.format(amount),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isWarning ? Colors.orange : const Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }
}
