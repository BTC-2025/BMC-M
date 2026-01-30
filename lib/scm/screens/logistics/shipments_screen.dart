import 'package:flutter/material.dart';
import '../../models/shipment.dart';
import '../../services/logistics_service.dart';

class ShipmentsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ShipmentsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  late Future<List<Shipment>> _shipmentsFuture;

  @override
  void initState() {
    super.initState();
    _shipmentsFuture = LogisticsService().getShipments();
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
          'Shipments',
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
        child: const Icon(Icons.local_shipping_rounded, color: Colors.white),
      ),
      body: FutureBuilder<List<Shipment>>(
        future: _shipmentsFuture,
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
            return const Center(child: Text('No shipments found'));
          }

          final shipments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: shipments.length,
            itemBuilder: (context, index) {
              final shipment = shipments[index];
              return _buildShipmentCard(shipment);
            },
          );
        },
      ),
    );
  }

  Widget _buildShipmentCard(Shipment shipment) {
    Color statusColor;
    switch (shipment.status) {
      case ShipmentStatus.delivered:
        statusColor = Colors.green;
        break;
      case ShipmentStatus.inTransit:
        statusColor = Colors.blue;
        break;
      case ShipmentStatus.delayed:
        statusColor = Colors.red;
        break;
      case ShipmentStatus.pending:
        statusColor = Colors.orange;
        break;
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
                shipment.id,
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
                  shipment.status.name.toUpperCase(),
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
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 12,
                color: Color(0xFFEF6C00),
              ),
              const SizedBox(width: 8),
              Text(
                shipment.origin,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B2559),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 4, bottom: 4),
            child: Container(
              width: 2,
              height: 20,
              color: const Color(0xFFEF6C00).withValues(alpha: 0.2),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 12,
                color: Color(0xFFEF6C00),
              ),
              const SizedBox(width: 8),
              Text(
                shipment.destination,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1B2559),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Carrier',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    shipment.carrier,
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
                    'Current Hub',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    shipment.currentHub,
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
                    'ETA',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    shipment.estimatedArrival.toString().split(' ')[0],
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
