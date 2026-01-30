import '../../domain/repositories/inventory_repository.dart';
import '../../models/inventory_model.dart';
import '../datasources/inventory_remote_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSource remoteDataSource;

  InventoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<InventoryItem>> getInventoryItems() async {
    return await remoteDataSource.fetchItems();
  }

  @override
  Future<void> addInventoryItem(InventoryItem item) async {
    await remoteDataSource.addItem(item);
  }
}
