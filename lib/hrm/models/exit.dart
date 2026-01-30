class ExitRecord {
  final String id;
  final String employeeId;
  final DateTime resignationDate;
  final DateTime lastWorkingDay;
  final String reason;
  final String exitInterviewNotes;
  final String clearanceStatus; // Pending / Cleared

  ExitRecord({
    required this.id,
    required this.employeeId,
    required this.resignationDate,
    required this.lastWorkingDay,
    required this.reason,
    required this.exitInterviewNotes,
    required this.clearanceStatus,
  });

  factory ExitRecord.fromJson(Map<String, dynamic> json) {
    return ExitRecord(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      resignationDate: DateTime.parse(json['resignationDate'] as String),
      lastWorkingDay: DateTime.parse(json['lastWorkingDay'] as String),
      reason: json['reason'] as String,
      exitInterviewNotes: json['exitInterviewNotes'] as String,
      clearanceStatus: json['clearanceStatus'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'resignationDate': resignationDate.toIso8601String(),
      'lastWorkingDay': lastWorkingDay.toIso8601String(),
      'reason': reason,
      'exitInterviewNotes': exitInterviewNotes,
      'clearanceStatus': clearanceStatus,
    };
  }
}
