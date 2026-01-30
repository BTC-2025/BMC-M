class CompanyAsset {
  final String id;
  final String name;
  final String type;
  final String serialNumber;
  final String? assignedToEmployeeId;
  final DateTime? issueDate;
  final DateTime? returnDate;
  final String status; // Available / Assigned / Maintenance / Damaged

  CompanyAsset({
    required this.id,
    required this.name,
    required this.type,
    required this.serialNumber,
    this.assignedToEmployeeId,
    this.issueDate,
    this.returnDate,
    required this.status,
  });

  factory CompanyAsset.fromJson(Map<String, dynamic> json) {
    return CompanyAsset(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      serialNumber: json['serialNumber'] as String,
      assignedToEmployeeId: json['assignedToEmployeeId'] as String?,
      issueDate: json['issueDate'] != null
          ? DateTime.parse(json['issueDate'] as String)
          : null,
      returnDate: json['returnDate'] != null
          ? DateTime.parse(json['returnDate'] as String)
          : null,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'serialNumber': serialNumber,
      'assignedToEmployeeId': assignedToEmployeeId,
      'issueDate': issueDate?.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'status': status,
    };
  }
}
