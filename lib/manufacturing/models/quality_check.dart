enum InspectionResult { pass, fail, pending, rework }

class QualityCheck {
  final String id;
  final String workOrderId;
  final String productName;
  final String batchNumber;
  final DateTime inspectionDate;
  final String inspectorName;
  final InspectionResult result;
  final int totalTested;
  final int passedCount;
  final int failedCount;
  final String comments;

  QualityCheck({
    required this.id,
    required this.workOrderId,
    required this.productName,
    required this.batchNumber,
    required this.inspectionDate,
    required this.inspectorName,
    required this.result,
    required this.totalTested,
    required this.passedCount,
    required this.failedCount,
    this.comments = '',
  });

  double get defeatRate =>
      totalTested == 0 ? 0 : (failedCount / totalTested) * 100;
}
