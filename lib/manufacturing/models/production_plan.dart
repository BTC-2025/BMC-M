enum PlanStatus { draft, confirmed, inProgress, completed }

class ProductionPlan {
  final String id;
  final String title; // e.g., "Feb 2024 Week 1 Plan"
  final DateTime startDate;
  final DateTime endDate;
  final PlanStatus status;
  final int totalWorkOrders;
  final double targetEfficiency; // e.g. 95.0
  final String createdBy;

  ProductionPlan({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.status = PlanStatus.draft,
    required this.totalWorkOrders,
    required this.targetEfficiency,
    required this.createdBy,
  });
}
