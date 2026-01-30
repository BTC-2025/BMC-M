import 'package:flutter/material.dart';
import '../../models/requisition.dart';
import '../../services/procurement_service.dart';

class RequisitionsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const RequisitionsScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  State<RequisitionsScreen> createState() => _RequisitionsScreenState();
}

class _RequisitionsScreenState extends State<RequisitionsScreen> {
  late Future<List<PurchaseRequisition>> _reqsFuture;

  @override
  void initState() {
    super.initState();
    _reqsFuture = ProcurementService().getRequisitions();
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
          'Requisitions',
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
        child: const Icon(Icons.post_add_rounded, color: Colors.white),
      ),
      body: FutureBuilder<List<PurchaseRequisition>>(
        future: _reqsFuture,
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
            return const Center(child: Text('No requisitions found'));
          }

          final reqs = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reqs.length,
            itemBuilder: (context, index) {
              final req = reqs[index];
              return _buildReqCard(req);
            },
          );
        },
      ),
    );
  }

  Widget _buildReqCard(PurchaseRequisition req) {
    Color statusColor;
    switch (req.status) {
      case RequisitionStatus.approved:
        statusColor = Colors.green;
        break;
      case RequisitionStatus.submitted:
        statusColor = Colors.blue;
        break;
      case RequisitionStatus.rejected:
        statusColor = Colors.red;
        break;
      case RequisitionStatus.converted:
        statusColor = Colors.purple;
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
                req.id,
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
                  req.status.name.toUpperCase(),
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
                Icons.business_rounded,
                color: Color(0xFFA3AED0),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                req.department,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requested By',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    req.requestedBy,
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
                    'Est. Cost',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    '\$${req.estimatedCost.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(color: Color(0xFFA3AED0), fontSize: 11),
                  ),
                  Text(
                    req.requestDate.toString().split(' ')[0],
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
