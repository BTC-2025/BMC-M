import '../models/production_plan.dart';

class ProductionPlanningService {
  static final ProductionPlanningService _instance =
      ProductionPlanningService._internal();
  factory ProductionPlanningService() => _instance;
  ProductionPlanningService._internal();

  final List<ProductionPlan> _plans = [
    ProductionPlan(
      id: 'plan_001',
      title: 'Jan 2026 Week 3 Plan',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 2)),
      status: PlanStatus.inProgress,
      totalWorkOrders: 12,
      targetEfficiency: 92.5,
      createdBy: 'Alex Johnson',
    ),
    ProductionPlan(
      id: 'plan_002',
      title: 'Jan 2026 Week 4 Plan',
      startDate: DateTime.now().add(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 10)),
      status: PlanStatus.confirmed,
      totalWorkOrders: 25,
      targetEfficiency: 95.0,
      createdBy: 'Alex Johnson',
    ),
    ProductionPlan(
      id: 'plan_003',
      title: 'Feb 2026 Monthly Forecast',
      startDate: DateTime.now().add(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 45)),
      status: PlanStatus.draft,
      totalWorkOrders: 150,
      targetEfficiency: 90.0,
      createdBy: 'Sarah Connors',
    ),
  ];

  Future<List<ProductionPlan>> getAllPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_plans);
  }
}
