enum QualityStatus { passed, failed, pending, reworked }

class FinishedGood {
  final String id;
  final String workOrderId;
  final String productName;
  final int quantityProduced;
  final String batchNumber;
  final String warehouseLocation;
  final QualityStatus qualityStatus;
  final DateTime completionDate;
  final int rejectedQuantity;

  FinishedGood({
    required this.id,
    required this.workOrderId,
    required this.productName,
    required this.quantityProduced,
    required this.batchNumber,
    required this.warehouseLocation,
    required this.qualityStatus,
    required this.completionDate,
    required this.rejectedQuantity,
  });

  int get netYield => quantityProduced - rejectedQuantity;
}
