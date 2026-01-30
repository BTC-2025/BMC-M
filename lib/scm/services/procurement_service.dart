import '../models/purchase_order.dart';
import '../models/requisition.dart';

class ProcurementService {
  static final ProcurementService _instance = ProcurementService._internal();
  factory ProcurementService() => _instance;
  ProcurementService._internal();

  final List<PurchaseOrder> _pos = [
    // ... existing POs
    PurchaseOrder(
      id: 'PO-2024-001',
      supplierName: 'Global Steel Co.',
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      totalAmount: 12500.0,
      status: PurchaseOrderStatus.approved,
      expectedDelivery: '2024-02-15',
    ),
    PurchaseOrder(
      id: 'PO-2024-002',
      supplierName: 'Precision Plastics',
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      totalAmount: 4500.0,
      status: PurchaseOrderStatus.pending,
      expectedDelivery: '2024-02-20',
    ),
    PurchaseOrder(
      id: 'PO-2024-003',
      supplierName: 'Swift Logistics',
      orderDate: DateTime.now().subtract(const Duration(days: 10)),
      totalAmount: 1200.0,
      status: PurchaseOrderStatus.received,
      expectedDelivery: '2024-02-01',
    ),
  ];

  final List<PurchaseRequisition> _requisitions = [
    PurchaseRequisition(
      id: 'REQ-001',
      department: 'Manufacturing',
      requestedBy: 'John Doe',
      requestDate: DateTime.now().subtract(const Duration(days: 1)),
      estimatedCost: 2500.0,
      status: RequisitionStatus.submitted,
    ),
    PurchaseRequisition(
      id: 'REQ-002',
      department: 'IT',
      requestedBy: 'Jane Smith',
      requestDate: DateTime.now().subtract(const Duration(days: 3)),
      estimatedCost: 1500.0,
      status: RequisitionStatus.approved,
    ),
  ];

  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_pos);
  }

  Future<List<PurchaseRequisition>> getRequisitions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_requisitions);
  }
}
