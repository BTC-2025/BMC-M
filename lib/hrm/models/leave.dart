class LeaveRequest {
  final String id;
  final String employeeId;
  final String leaveType; // Casual / Sick / Paid
  final DateTime fromDate;
  final DateTime toDate;
  final int totalDays;
  final String reason;
  final String status; // Pending / Approved / Rejected
  final String? approvedBy;
  final DateTime appliedDate;

  LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.totalDays,
    required this.reason,
    required this.status,
    this.approvedBy,
    required this.appliedDate,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      leaveType: json['leaveType'] as String,
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: DateTime.parse(json['toDate'] as String),
      totalDays: json['totalDays'] as int,
      reason: json['reason'] as String,
      status: json['status'] as String,
      approvedBy: json['approvedBy'] as String?,
      appliedDate: DateTime.parse(json['appliedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'leaveType': leaveType,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'totalDays': totalDays,
      'reason': reason,
      'status': status,
      'approvedBy': approvedBy,
      'appliedDate': appliedDate.toIso8601String(),
    };
  }
}
