import 'package:flutter/material.dart';
import '../../models/purchase_order.dart';
import '../../services/procurement_service.dart';

class PurchaseOrdersScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const PurchaseOrdersScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<PurchaseOrdersScreen> createState() => _PurchaseOrdersScreenState();
}

class _PurchaseOrdersScreenState extends State<PurchaseOrdersScreen> {
  late Future<List<PurchaseOrder>> _posFuture;

  @override
  void initState() {
    super.initState();
    _posFuture = ProcurementService().getPurchaseOrders();
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
            color: Color(0xFFEF6C00),
            size: 20,
          ),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Purchase Orders',
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
            onPressed: widget.onMenu,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFEF6C00),
        child: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
      ),
      body: FutureBuilder<List<PurchaseOrder>>(
        future: _posFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFEF6C00)),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No purchase orders found'));
          }

          final pos = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pos.length,
            itemBuilder: (context, index) {
              final po = pos[index];
              return _buildPoCard(po);
            },
          );
        },
      ),
    );
  }

  Widget _buildPoCard(PurchaseOrder po) {
    Color statusColor;
    switch (po.status) {
      case PurchaseOrderStatus.approved:
        statusColor = Colors.blue;
        break;
      case PurchaseOrderStatus.pending:
        statusColor = Colors.orange;
        break;
      case PurchaseOrderStatus.received:
        statusColor = Colors.green;
        break;
      case PurchaseOrderStatus.shipped:
        statusColor = Colors.purple;
        break;
      case PurchaseOrderStatus.cancelled:
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
              Text(
                po.id,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF6C00),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  po.status.name.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            po.supplierName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    '\$${po.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Date',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    po.orderDate.toString().split(' ')[0],
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ex. Delivery',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    po.expectedDelivery,
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
