import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/bill_of_material.dart';

class BomDetailsScreen extends StatelessWidget {
  final BillOfMaterial bom;

  const BomDetailsScreen({super.key, required this.bom});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

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
        title: Text(
          'BOM Details: ${bom.version}',
          style: const TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(currency),
            const SizedBox(height: 32),
            const Text(
              'Raw Materials / Components',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 16),
            _buildComponentsList(currency),
            const SizedBox(height: 32),
            _buildCostBreakdown(currency),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(NumberFormat currency) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
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
              const Text(
                'FINISHED PRODUCT',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  bom.version,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            bom.productName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderStat(
                'Total Est. Cost',
                currency.format(bom.totalEstimatedCost),
              ),
              _buildHeaderStat('Components', '${bom.components.length} Items'),
              _buildHeaderStat('Status', bom.isActive ? 'Active' : 'Archived'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildComponentsList(NumberFormat currency) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bom.components.length,
      itemBuilder: (context, index) {
        final comp = bom.components[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.layers_outlined,
                  color: Color(0xFF2E7D32),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comp.itemName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${comp.quantity} ${comp.uom} • ${comp.wastagePercentage}% Waste',
                      style: const TextStyle(
                        color: Color(0xFFA3AED0),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currency.format(comp.estimatedCost * comp.quantity),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCostBreakdown(NumberFormat currency) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cost Breakdown (Per Unit)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          _buildCostRow(
            'Materials (Inc. Wastage)',
            currency.format(
              bom.totalEstimatedCost -
                  bom.laborCostPerUnit -
                  bom.overheadCostPerUnit,
            ),
          ),
          _buildCostRow('Direct Labor', currency.format(bom.laborCostPerUnit)),
          _buildCostRow(
            'Manufacturing Overhead',
            currency.format(bom.overheadCostPerUnit),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildCostRow(
            'Final Unit Cost',
            currency.format(bom.totalEstimatedCost),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal
                  ? const Color(0xFF1B2559)
                  : const Color(0xFFA3AED0),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF1B2559),
              fontWeight: FontWeight.bold,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
