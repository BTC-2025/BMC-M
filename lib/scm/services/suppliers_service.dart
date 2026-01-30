import '../models/supplier.dart';

class SuppliersService {
  static final SuppliersService _instance = SuppliersService._internal();
  factory SuppliersService() => _instance;
  SuppliersService._internal();

  final List<Supplier> _suppliers = [
    Supplier(
      id: 'SUP-001',
      name: 'Global Steel Co.',
      contactPerson: 'John Miller',
      email: 'john@globalsteel.com',
      phone: '+1 555-0101',
      category: 'Raw Materials',
      rating: 4.8,
      status: 'Active',
    ),
    Supplier(
      id: 'SUP-002',
      name: 'Precision Plastics',
      contactPerson: 'Sarah Chen',
      email: 'sarah@precisionplastics.com',
      phone: '+1 555-0102',
      category: 'Components',
      rating: 4.5,
      status: 'Active',
    ),
    Supplier(
      id: 'SUP-003',
      name: 'Swift Logistics',
      contactPerson: 'Michael Ross',
      email: 'michael@swiftlogistics.com',
      phone: '+1 555-0103',
      category: 'Shipping',
      rating: 4.2,
      status: 'Active',
    ),
    Supplier(
      id: 'SUP-004',
      name: 'Vertex Electronics',
      contactPerson: 'Emma Watson',
      email: 'emma@vertex.com',
      phone: '+1 555-0104',
      category: 'Electronics',
      rating: 3.9,
      status: 'Suspended',
    ),
  ];

  Future<List<Supplier>> getSuppliers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_suppliers);
  }
}
