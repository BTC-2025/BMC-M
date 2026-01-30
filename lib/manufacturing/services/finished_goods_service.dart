import '../models/finished_good.dart';

class FinishedGoodsService {
  static final FinishedGoodsService _instance =
      FinishedGoodsService._internal();
  factory FinishedGoodsService() => _instance;
  FinishedGoodsService._internal();

  final List<FinishedGood> _items = [
    FinishedGood(
      id: 'FG-001',
      workOrderId: 'WO-2024-001',
      productName: 'T-Shirt (XL)',
      quantityProduced: 500,
      batchNumber: 'B-240115-01',
      warehouseLocation: 'Zone A-04',
      qualityStatus: QualityStatus.passed,
      completionDate: DateTime.now().subtract(const Duration(days: 2)),
      rejectedQuantity: 5,
    ),
    FinishedGood(
      id: 'FG-002',
      workOrderId: 'WO-2024-002',
      productName: 'Denim Jeans (32)',
      quantityProduced: 200,
      batchNumber: 'B-240116-02',
      warehouseLocation: 'Zone B-12',
      qualityStatus: QualityStatus.reworked,
      completionDate: DateTime.now().subtract(const Duration(days: 1)),
      rejectedQuantity: 12,
    ),
    FinishedGood(
      id: 'FG-003',
      workOrderId: 'WO-2024-005',
      productName: 'Leather Jacket',
      quantityProduced: 50,
      batchNumber: 'B-240120-05',
      warehouseLocation: 'Zone C-01',
      qualityStatus: QualityStatus.pending,
      completionDate: DateTime.now(),
      rejectedQuantity: 0,
    ),
  ];

  Future<List<FinishedGood>> getAllFinishedGoods() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_items);
  }
}
