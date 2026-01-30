enum RequisitionStatus { draft, submitted, approved, rejected, converted }

class PurchaseRequisition {
  final String id;
  final String department;
  final String requestedBy;
  final DateTime requestDate;
  final double estimatedCost;
  final RequisitionStatus status;

  PurchaseRequisition({
    required this.id,
    required this.department,
    required this.requestedBy,
    required this.requestDate,
    required this.estimatedCost,
    required this.status,
  });
}
