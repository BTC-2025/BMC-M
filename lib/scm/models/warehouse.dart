class Warehouse {
  final String id;
  final String name;
  final String location;
  final double capacity; // in percentage
  final int totalItems;
  final String manager;

  Warehouse({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.totalItems,
    required this.manager,
  });
}
