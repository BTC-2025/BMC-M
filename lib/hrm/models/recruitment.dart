class Candidate {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String appliedPosition;
  final String? resumeUrl;
  final DateTime? interviewDate;
  final String
  interviewStatus; // Applied / Interviewing / Offered / Joined / Rejected
  final double? offeredSalary;
  final String joiningStatus; // Pending / Joined / Cancelled

  Candidate({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.appliedPosition,
    this.resumeUrl,
    this.interviewDate,
    required this.interviewStatus,
    this.offeredSalary,
    required this.joiningStatus,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      appliedPosition: json['appliedPosition'] as String,
      resumeUrl: json['resumeUrl'] as String?,
      interviewDate: json['interviewDate'] != null
          ? DateTime.parse(json['interviewDate'] as String)
          : null,
      interviewStatus: json['interviewStatus'] as String,
      offeredSalary: (json['offeredSalary'] as num?)?.toDouble(),
      joiningStatus: json['joiningStatus'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'appliedPosition': appliedPosition,
      'resumeUrl': resumeUrl,
      'interviewDate': interviewDate?.toIso8601String(),
      'interviewStatus': interviewStatus,
      'offeredSalary': offeredSalary,
      'joiningStatus': joiningStatus,
    };
  }
}
