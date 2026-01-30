import '../models/quality_check.dart';

class QualityControlService {
  static final QualityControlService _instance =
      QualityControlService._internal();
  factory QualityControlService() => _instance;
  QualityControlService._internal();

  final List<QualityCheck> _checks = [
    QualityCheck(
      id: 'qc_001',
      workOrderId: 'WO-2024-045',
      productName: 'Executive Office Desk',
      batchNumber: 'B-240115',
      inspectionDate: DateTime.now().subtract(const Duration(hours: 5)),
      inspectorName: 'Alice Green',
      result: InspectionResult.pass,
      totalTested: 50,
      passedCount: 48,
      failedCount: 2,
      comments: 'Minor scratches on 2 units. Logic passed.',
    ),
    QualityCheck(
      id: 'qc_002',
      workOrderId: 'WO-2024-046',
      productName: 'Ergonomic Office Chair',
      batchNumber: 'B-240116',
      inspectionDate: DateTime.now().subtract(const Duration(days: 1)),
      inspectorName: 'Bob White',
      result: InspectionResult.pending,
      totalTested: 0,
      passedCount: 0,
      failedCount: 0,
      comments: 'Awaiting assembly completion.',
    ),
    QualityCheck(
      id: 'qc_003',
      workOrderId: 'WO-2024-042',
      productName: 'Executive Desk - Custom',
      batchNumber: 'B-240110',
      inspectionDate: DateTime.now().subtract(const Duration(days: 3)),
      inspectorName: 'Alice Green',
      result: InspectionResult.fail,
      totalTested: 10,
      passedCount: 6,
      failedCount: 4,
      comments: 'Structural integrity failure in batch.',
    ),
  ];

  Future<List<QualityCheck>> getAllInspections() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_checks);
  }
}
