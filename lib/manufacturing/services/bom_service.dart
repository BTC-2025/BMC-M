import '../models/bill_of_material.dart';

class BomService {
  // Singleton
  static final BomService _instance = BomService._internal();
  factory BomService() => _instance;
  BomService._internal();

  final List<BillOfMaterial> _boms = [
    BillOfMaterial(
      id: 'bom_001',
      productId: 'prod_table_001',
      productName: 'Executive Office Desk',
      version: 'v1.0',
      isActive: true,
      laborCostPerUnit: 45.0,
      overheadCostPerUnit: 15.0,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      components: [
        BomComponent(
          itemId: 'item_wood_oak',
          itemName: 'Oak Wood Plank',
          quantity: 5,
          uom: 'Units',
          wastagePercentage: 5.0, // 5% waste
          estimatedCost: 20.0,
        ),
        BomComponent(
          itemId: 'item_varnish',
          itemName: 'Wood Varnish',
          quantity: 0.5,
          uom: 'Liters',
          wastagePercentage: 2.0,
          estimatedCost: 12.0,
        ),
        BomComponent(
          itemId: 'item_screw_set',
          itemName: 'Assembly Screws (Set)',
          quantity: 1,
          uom: 'Pack',
          estimatedCost: 3.5,
        ),
      ],
    ),
    BillOfMaterial(
      id: 'bom_002',
      productId: 'prod_chair_erg',
      productName: 'Ergonomic Office Chair',
      version: 'v2.1',
      isActive: true,
      laborCostPerUnit: 25.0,
      overheadCostPerUnit: 10.0,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      components: [
        BomComponent(
          itemId: 'item_mesh_fabric',
          itemName: 'Breathable Mesh Fabric',
          quantity: 1.2,
          uom: 'Meters',
          wastagePercentage: 8.0,
          estimatedCost: 15.0,
        ),
        BomComponent(
          itemId: 'item_metal_base',
          itemName: 'Aluminum Wheel Base',
          quantity: 1,
          uom: 'Unit',
          estimatedCost: 35.0,
        ),
        BomComponent(
          itemId: 'item_piston',
          itemName: 'Gas Lift Piston',
          quantity: 1,
          uom: 'Unit',
          estimatedCost: 8.0,
        ),
      ],
    ),
  ];

  Future<List<BillOfMaterial>> getAllBoms() async {
    await Future.delayed(const Duration(milliseconds: 600)); // Sim network
    return List.from(_boms);
  }

  Future<BillOfMaterial?> getBomById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return _boms.firstWhere((b) => b.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> createBom(BillOfMaterial bom) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _boms.add(bom);
  }
}
