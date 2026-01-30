import '../models/production_cost.dart';

class ProductionCostingService {
  static final ProductionCostingService _instance =
      ProductionCostingService._internal();
  factory ProductionCostingService() => _instance;
  ProductionCostingService._internal();

  final List<ProductionCost> _costs = [
    ProductionCost(
      id: 'cost_001',
      workOrderId: 'WO-2024-045',
      productName: 'Executive Office Desk',
      materialCost: 4500.00,
      laborCost: 1200.00,
      overheadCost: 300.00,
      wastageCost: 150.00,
      plannedCost: 6000.00,
      calculationDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ProductionCost(
      id: 'cost_002',
      workOrderId: 'WO-2024-042',
      productName: 'Executive Office Desk - Custom',
      materialCost: 5500.00,
      laborCost: 1500.00,
      overheadCost: 350.00,
      wastageCost: 50.00,
      plannedCost: 7200.00,
      calculationDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  Future<List<ProductionCost>> getCostReports() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_costs);
  }
}
