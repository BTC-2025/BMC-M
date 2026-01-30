class Supplier {
  final String id;
  final String name;
  final String contactPerson;
  final String email;
  final String phone;
  final String category; // e.g., Raw Materials, Logistics, Services
  final double rating;
  final String status; // Active, Suspended, Inactive

  Supplier({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.email,
    required this.phone,
    required this.category,
    required this.rating,
    required this.status,
  });
}
