import '../../models/inventory_model.dart';
import '../../../../infrastructure/error_reporting/error_reporter.dart';

abstract class InventoryRemoteDataSource {
  Future<List<InventoryItem>> fetchItems();
  Future<void> addItem(InventoryItem item);
}

class InventoryRemoteDataSourceImpl implements InventoryRemoteDataSource {
  // Pass ApiClient here in future

  @override
  Future<List<InventoryItem>> fetchItems() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API
      return [
        InventoryItem(
          id: '1',
          name: 'iPhone 15 Pro',
          sku: 'PROD-001',
          category: 'Electronics',
          salePrice: 999.0,
          costPrice: 800.0,
          currentStock: 150,
          reorderPoint: 20,
          status: 'In Stock',
        ),
        InventoryItem(
          id: '2',
          name: 'MacBook Air M2',
          sku: 'PROD-002',
          category: 'Electronics',
          salePrice: 1199.0,
          costPrice: 1000.0,
          currentStock: 15,
          reorderPoint: 10,
          status: 'Low Stock',
        ),
      ];
    } catch (e, s) {
      ErrorReporter.report(
        e,
        s,
        context: 'InventoryRemoteDataSource.fetchItems',
      );
      rethrow;
    }
  }

  @override
  Future<void> addItem(InventoryItem item) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // API logic
    } catch (e, s) {
      ErrorReporter.report(e, s, context: 'InventoryRemoteDataSource.addItem');
      rethrow;
    }
  }
}
