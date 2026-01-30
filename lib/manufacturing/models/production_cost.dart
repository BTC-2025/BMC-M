class ProductionCost {
  final String id;
  final String workOrderId;
  final String productName;
  final double materialCost;
  final double laborCost;
  final double overheadCost;
  final double wastageCost;
  final double plannedCost;
  final DateTime calculationDate;

  ProductionCost({
    required this.id,
    required this.workOrderId,
    required this.productName,
    required this.materialCost,
    required this.laborCost,
    required this.overheadCost,
    required this.wastageCost,
    required this.plannedCost,
    required this.calculationDate,
  });

  double get totalCost => materialCost + laborCost + overheadCost + wastageCost;
  double get variance => totalCost - plannedCost;
  double get variancePercentage => (variance / plannedCost) * 100;
}
