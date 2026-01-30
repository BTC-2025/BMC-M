class Shift {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final int breakDurationMinutes;
  final String applicableDepartmentId;
  final String status; // Active / Inactive

  Shift({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.breakDurationMinutes,
    required this.applicableDepartmentId,
    required this.status,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      breakDurationMinutes: json['breakDurationMinutes'] as int,
      applicableDepartmentId: json['applicableDepartmentId'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'breakDurationMinutes': breakDurationMinutes,
      'applicableDepartmentId': applicableDepartmentId,
      'status': status,
    };
  }
}
