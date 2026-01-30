class BomComponent {
  final String itemId;
  final String itemName; // Display name
  final double quantity; // Quantity needed per unit of finished good
  final String uom; // Unit of Measure (e.g., kg, meters, pcs)
  final double wastagePercentage; // Expected wastage
  final double estimatedCost; // Cost per unit of this component

  BomComponent({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.uom,
    this.wastagePercentage = 0.0,
    this.estimatedCost = 0.0,
  });
}

class BillOfMaterial {
  final String id;
  final String productId; // The finished good ID
  final String productName;
  final String version; // e.g., 'v1.0'
  final bool isActive;
  final List<BomComponent> components;
  final double laborCostPerUnit;
  final double overheadCostPerUnit;
  final DateTime createdAt;

  BillOfMaterial({
    required this.id,
    required this.productId,
    required this.productName,
    required this.version,
    this.isActive = true,
    required this.components,
    this.laborCostPerUnit = 0.0,
    this.overheadCostPerUnit = 0.0,
    required this.createdAt,
  });

  // Derived: Total Estimated Cost
  double get totalEstimatedCost {
    double materialCost = components.fold(0.0, (sum, comp) {
      double requiredQty = comp.quantity * (1 + comp.wastagePercentage / 100);
      return sum + (requiredQty * comp.estimatedCost);
    });
    return materialCost + laborCostPerUnit + overheadCostPerUnit;
  }
}
