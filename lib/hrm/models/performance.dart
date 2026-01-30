class PerformanceReview {
  final String id;
  final String employeeId;
  final String reviewPeriod;
  final double kpiScore;
  final String managerFeedback;
  final String employeeFeedback;
  final double finalRating;
  final DateTime reviewDate;

  PerformanceReview({
    required this.id,
    required this.employeeId,
    required this.reviewPeriod,
    required this.kpiScore,
    required this.managerFeedback,
    required this.employeeFeedback,
    required this.finalRating,
    required this.reviewDate,
  });

  factory PerformanceReview.fromJson(Map<String, dynamic> json) {
    return PerformanceReview(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      reviewPeriod: json['reviewPeriod'] as String,
      kpiScore: (json['kpiScore'] as num).toDouble(),
      managerFeedback: json['managerFeedback'] as String,
      employeeFeedback: json['employeeFeedback'] as String,
      finalRating: (json['finalRating'] as num).toDouble(),
      reviewDate: DateTime.parse(json['reviewDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'reviewPeriod': reviewPeriod,
      'kpiScore': kpiScore,
      'managerFeedback': managerFeedback,
      'employeeFeedback': employeeFeedback,
      'finalRating': finalRating,
      'reviewDate': reviewDate.toIso8601String(),
    };
  }
}
