import '../models/warehouse.dart';

class WarehouseService {
  static final WarehouseService _instance = WarehouseService._internal();
  factory WarehouseService() => _instance;
  WarehouseService._internal();

  final List<Warehouse> _warehouses = [
    Warehouse(
      id: 'WH-001',
      name: 'Main Distribution Center',
      location: 'Chicago, IL',
      capacity: 85.0,
      totalItems: 12500,
      manager: 'Robert Davis',
    ),
    Warehouse(
      id: 'WH-002',
      name: 'West Coast Hub',
      location: 'Los Angeles, CA',
      capacity: 62.5,
      totalItems: 8400,
      manager: 'Linda Wilson',
    ),
    Warehouse(
      id: 'WH-003',
      name: 'East Coast Storage',
      location: 'Newark, NJ',
      capacity: 45.0,
      totalItems: 5200,
      manager: 'James Bond',
    ),
  ];

  Future<List<Warehouse>> getWarehouses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_warehouses);
  }
}
