enum PurchaseOrderStatus {
  draft,
  pending,
  approved,
  shipped,
  received,
  cancelled,
}

class PurchaseOrder {
  final String id;
  final String supplierName;
  final DateTime orderDate;
  final double totalAmount;
  final PurchaseOrderStatus status;
  final String expectedDelivery;

  PurchaseOrder({
    required this.id,
    required this.supplierName,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.expectedDelivery,
  });
}
