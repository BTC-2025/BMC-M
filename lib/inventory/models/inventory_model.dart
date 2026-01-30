class InventoryItem {
  final String id;
  final String name;
  final String sku;
  final String category;
  final double salePrice;
  final double costPrice;
  final int currentStock;
  final int reorderPoint;
  final String status; // 'In Stock', 'Low Stock', 'Out of Stock'

  InventoryItem({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.salePrice,
    required this.costPrice,
    required this.currentStock,
    required this.reorderPoint,
    required this.status,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      category: json['category'] as String,
      salePrice: (json['salePrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num).toDouble(),
      currentStock: json['currentStock'] as int,
      reorderPoint: json['reorderPoint'] as int,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'salePrice': salePrice,
      'costPrice': costPrice,
      'currentStock': currentStock,
      'reorderPoint': reorderPoint,
      'status': status,
    };
  }
}
