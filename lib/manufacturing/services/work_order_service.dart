import '../models/work_order.dart';

class WorkOrderService {
  static final WorkOrderService _instance = WorkOrderService._internal();
  factory WorkOrderService() => _instance;
  WorkOrderService._internal();

  final List<WorkOrder> _workOrders = [
    WorkOrder(
      id: 'wo_001',
      orderNumber: 'WO-2024-045',
      bomId: 'bom_001',
      productName: 'Executive Office Desk',
      quantity: 50,
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      dueDate: DateTime.now().add(const Duration(days: 5)),
      actualStartDate: DateTime.now().subtract(const Duration(days: 2)),
      status: WorkOrderStatus.inProgress,
      assignedTo: 'John Doe (Sup)',
      productionLine: 'Line A-01',
      priority: 'High',
      completionPercentage: 0.45,
    ),
    WorkOrder(
      id: 'wo_002',
      orderNumber: 'WO-2024-046',
      bomId: 'bom_002',
      productName: 'Ergonomic Office Chair',
      quantity: 200,
      startDate: DateTime.now().add(const Duration(days: 1)),
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: WorkOrderStatus.planned,
      assignedTo: 'Jane Smith (Sup)',
      productionLine: 'Line B-04',
      priority: 'Medium',
      completionPercentage: 0.0,
    ),
    WorkOrder(
      id: 'wo_003',
      orderNumber: 'WO-2024-042',
      bomId: 'bom_001',
      productName: 'Executive Office Desk - Custom',
      quantity: 10,
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      actualStartDate: DateTime.now().subtract(const Duration(days: 10)),
      actualEndDate: DateTime.now().subtract(const Duration(days: 1)),
      status: WorkOrderStatus.qaPending,
      assignedTo: 'Mike Ross',
      productionLine: 'Line A-01',
      priority: 'Critical',
      completionPercentage: 0.95,
    ),
  ];

  Future<List<WorkOrder>> getAllWorkOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_workOrders);
  }

  Future<void> createWorkOrder(WorkOrder order) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _workOrders.add(order);
  }

  // Filter helpers
  Future<List<WorkOrder>> getOrdersByStatus(WorkOrderStatus status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _workOrders.where((o) => o.status == status).toList();
  }
}
