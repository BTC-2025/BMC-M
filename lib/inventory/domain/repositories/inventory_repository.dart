import '../../models/inventory_model.dart';

abstract class InventoryRepository {
  Future<List<InventoryItem>> getInventoryItems();
  Future<void> addInventoryItem(InventoryItem item);
}
