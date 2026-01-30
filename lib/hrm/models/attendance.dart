class Attendance {
  final String id;
  final String employeeId;
  final DateTime date;
  final String? checkInTime;
  final String? checkOutTime;
  final double workingHours;
  final String status; // Present / Absent / Late / Half Day
  final String? locationDeviceId;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    required this.workingHours,
    required this.status,
    this.locationDeviceId,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      date: DateTime.parse(json['date'] as String),
      checkInTime: json['checkInTime'] as String?,
      checkOutTime: json['checkOutTime'] as String?,
      workingHours: (json['workingHours'] as num).toDouble(),
      status: json['status'] as String,
      locationDeviceId: json['locationDeviceId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'date': date.toIso8601String(),
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'workingHours': workingHours,
      'status': status,
      'locationDeviceId': locationDeviceId,
    };
  }
}
