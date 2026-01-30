enum WorkOrderStatus { planned, inProgress, qaPending, completed, cancelled }

extension WorkOrderStatusExtension on WorkOrderStatus {
  String get label {
    switch (this) {
      case WorkOrderStatus.planned:
        return 'Planned';
      case WorkOrderStatus.inProgress:
        return 'In Progress';
      case WorkOrderStatus.qaPending:
        return 'QA Pending';
      case WorkOrderStatus.completed:
        return 'Completed';
      case WorkOrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class WorkOrder {
  final String id;
  final String orderNumber;
  final String bomId;
  final String productName;
  final int quantity;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime? actualStartDate;
  final DateTime? actualEndDate;
  final WorkOrderStatus status;
  final String assignedTo; // Employee ID or Name
  final String productionLine;
  final String priority; // 'High', 'Medium', 'Low'
  final double completionPercentage; // 0.0 to 1.0

  WorkOrder({
    required this.id,
    required this.orderNumber,
    required this.bomId,
    required this.productName,
    required this.quantity,
    required this.startDate,
    required this.dueDate,
    this.actualStartDate,
    this.actualEndDate,
    this.status = WorkOrderStatus.planned,
    required this.assignedTo,
    this.productionLine = 'Line 01',
    this.priority = 'Medium',
    this.completionPercentage = 0.0,
  });
}
