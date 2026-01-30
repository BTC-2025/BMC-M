class HrDocument {
  final String id;
  final String employeeId;
  final String type; // Aadhar, PAN, Offer Letter
  final String fileUrl;
  final DateTime? expiryDate;
  final String verificationStatus; // Verified / Pending / Rejected

  HrDocument({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.fileUrl,
    this.expiryDate,
    required this.verificationStatus,
  });

  factory HrDocument.fromJson(Map<String, dynamic> json) {
    return HrDocument(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      type: json['type'] as String,
      fileUrl: json['fileUrl'] as String,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      verificationStatus: json['verificationStatus'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'type': type,
      'fileUrl': fileUrl,
      'expiryDate': expiryDate?.toIso8601String(),
      'verificationStatus': verificationStatus,
    };
  }
}
