import '../models/material_consumption.dart';

class MaterialConsumptionService {
  static final MaterialConsumptionService _instance =
      MaterialConsumptionService._internal();
  factory MaterialConsumptionService() => _instance;
  MaterialConsumptionService._internal();

  final List<MaterialConsumption> _logs = [
    MaterialConsumption(
      id: 'cons_001',
      workOrderId: 'WO-2024-045',
      itemId: 'item_wood_oak',
      itemName: 'Oak Wood Plank',
      plannedQuantity: 250,
      actualQuantity: 255,
      wastageQuantity: 5,
      uom: 'Units',
      loggedAt: DateTime.now().subtract(const Duration(hours: 4)),
      loggedBy: 'John Doe',
    ),
    MaterialConsumption(
      id: 'cons_002',
      workOrderId: 'WO-2024-045',
      itemId: 'item_varnish',
      itemName: 'Wood Varnish',
      plannedQuantity: 25,
      actualQuantity: 24,
      wastageQuantity: 0.5,
      uom: 'Liters',
      loggedAt: DateTime.now().subtract(const Duration(hours: 2)),
      loggedBy: 'John Doe',
    ),
  ];

  Future<List<MaterialConsumption>> getConsumptionLogs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_logs);
  }
}
