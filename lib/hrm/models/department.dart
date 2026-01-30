class Department {
  final String id;
  final String name;
  final String departmentHead;
  final String description;
  final DateTime createdDate;

  Department({
    required this.id,
    required this.name,
    required this.departmentHead,
    required this.description,
    required this.createdDate,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as String,
      name: json['name'] as String,
      departmentHead: json['departmentHead'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentHead': departmentHead,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
