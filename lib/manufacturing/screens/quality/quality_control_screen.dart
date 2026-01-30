import 'package:flutter/material.dart';
import '../../models/quality_check.dart';
import '../../services/quality_control_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class QualityControlScreen extends StatefulWidget {
  const QualityControlScreen({super.key});

  @override
  State<QualityControlScreen> createState() => _QualityControlScreenState();
}

class _QualityControlScreenState extends State<QualityControlScreen> {
  late Future<List<QualityCheck>> _qcFuture;

  @override
  void initState() {
    super.initState();
    _qcFuture = QualityControlService().getAllInspections();
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
          'Quality Control',
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
        selectedItem: 'QC Inspections', // Mapping
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<QualityCheck>>(
        future: _qcFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No inspections found'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildQcCard(snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildQcCard(QualityCheck qc) {
    Color statusColor;
    Color statusBgColor;
    IconData icon;

    switch (qc.result) {
      case InspectionResult.pass:
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1);
        icon = Icons.check_circle_outline;
        break;
      case InspectionResult.fail:
        statusColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: 0.1);
        icon = Icons.cancel_outlined;
        break;
      case InspectionResult.rework:
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1);
        icon = Icons.build_circle_outlined;
        break;
      case InspectionResult.pending:
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withValues(alpha: 0.1);
        icon = Icons.hourglass_empty;
        break;
    }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qc.workOrderId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    Text(
                      qc.productName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA3AED0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: statusColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      qc.result.name.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Batch', qc.batchNumber),
              _buildMetric('Inspector', qc.inspectorName),
              _buildMetric('Tested', '${qc.totalTested} Units'),
            ],
          ),
          if (qc.failedCount > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${qc.failedCount} Failed (${qc.defeatRate.toStringAsFixed(1)}%) - ${qc.comments}',
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2B3674),
          ),
        ),
      ],
    );
  }
}
