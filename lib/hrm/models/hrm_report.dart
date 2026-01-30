class HrmReport {
  final String id;
  final String name;
  final String module;
  final String dateRange;
  final String generatedByEmployeeId;
  final DateTime generatedDate;

  HrmReport({
    required this.id,
    required this.name,
    required this.module,
    required this.dateRange,
    required this.generatedByEmployeeId,
    required this.generatedDate,
  });

  factory HrmReport.fromJson(Map<String, dynamic> json) {
    return HrmReport(
      id: json['id'] as String,
      name: json['name'] as String,
      module: json['module'] as String,
      dateRange: json['dateRange'] as String,
      generatedByEmployeeId: json['generatedByEmployeeId'] as String,
      generatedDate: DateTime.parse(json['generatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'module': module,
      'dateRange': dateRange,
      'generatedByEmployeeId': generatedByEmployeeId,
      'generatedDate': generatedDate.toIso8601String(),
    };
  }
}
