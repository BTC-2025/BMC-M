class HrUserRole {
  final String id;
  final String name; // Admin, HR, Manager, Employee
  final List<String> permissions;
  final String status; // Active / Inactive

  HrUserRole({
    required this.id,
    required this.name,
    required this.permissions,
    required this.status,
  });

  factory HrUserRole.fromJson(Map<String, dynamic> json) {
    return HrUserRole(
      id: json['id'] as String,
      name: json['name'] as String,
      permissions: List<String>.from(json['permissions'] as List),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
      'status': status,
    };
  }
}
