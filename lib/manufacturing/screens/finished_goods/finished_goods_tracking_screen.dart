import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/finished_good.dart';
import '../../services/finished_goods_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class FinishedGoodsTrackingScreen extends StatefulWidget {
  const FinishedGoodsTrackingScreen({super.key});

  @override
  State<FinishedGoodsTrackingScreen> createState() =>
      _FinishedGoodsTrackingScreenState();
}

class _FinishedGoodsTrackingScreenState
    extends State<FinishedGoodsTrackingScreen> {
  late Future<List<FinishedGood>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = FinishedGoodsService().getAllFinishedGoods();
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
          'Finished Goods',
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
        selectedItem: 'Finished Goods',
      ),
      body: FutureBuilder<List<FinishedGood>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No finished goods tracked yet.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildFinishedGoodCard(items[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildFinishedGoodCard(FinishedGood item) {
    Color statusColor;
    switch (item.qualityStatus) {
      case QualityStatus.passed:
        statusColor = Colors.green;
        break;
      case QualityStatus.failed:
        statusColor = Colors.red;
        break;
      case QualityStatus.reworked:
        statusColor = Colors.orange;
        break;
      case QualityStatus.pending:
        statusColor = Colors.blue;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Batch: ${item.batchNumber}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.qualityStatus.name.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric(
                'Yield Qty',
                '${item.netYield} / ${item.quantityProduced}',
              ),
              _buildMetric('Warehouse', item.warehouseLocation),
              _buildMetric(
                'Completed',
                DateFormat('MMM dd').format(item.completionDate),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.assignment_turned_in_outlined,
                size: 14,
                color: Color(0xFFA3AED0),
              ),
              const SizedBox(width: 6),
              Text(
                'Source WO: ${item.workOrderId}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA3AED0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (item.rejectedQuantity > 0)
                Text(
                  '${item.rejectedQuantity} Rejected',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
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
