class Designation {
  final String id;
  final String name;
  final String departmentId;
  final String description;
  final String level; // Grade / Level
  final DateTime createdDate;

  Designation({
    required this.id,
    required this.name,
    required this.departmentId,
    required this.description,
    required this.level,
    required this.createdDate,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'] as String,
      name: json['name'] as String,
      departmentId: json['departmentId'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentId': departmentId,
      'description': description,
      'level': level,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
