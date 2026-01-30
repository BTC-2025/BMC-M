class MaterialConsumption {
  final String id;
  final String workOrderId;
  final String itemId;
  final String itemName;
  final double plannedQuantity;
  final double actualQuantity;
  final double wastageQuantity;
  final String uom;
  final DateTime loggedAt;
  final String loggedBy;

  MaterialConsumption({
    required this.id,
    required this.workOrderId,
    required this.itemId,
    required this.itemName,
    required this.plannedQuantity,
    this.actualQuantity = 0.0,
    this.wastageQuantity = 0.0,
    required this.uom,
    required this.loggedAt,
    required this.loggedBy,
  });

  double get variance =>
      actualQuantity - plannedQuantity; // Positive means over-consumption
}
