class Training {
  final String id;
  final String name;
  final String trainer;
  final DateTime trainingDate;
  final String duration;
  final List<String> participantEmployeeIds;
  final String completionStatus; // Upcoming / Ongoing / Completed
  final String? feedback;

  Training({
    required this.id,
    required this.name,
    required this.trainer,
    required this.trainingDate,
    required this.duration,
    required this.participantEmployeeIds,
    required this.completionStatus,
    this.feedback,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'] as String,
      name: json['name'] as String,
      trainer: json['trainer'] as String,
      trainingDate: DateTime.parse(json['trainingDate'] as String),
      duration: json['duration'] as String,
      participantEmployeeIds: List<String>.from(
        json['participantEmployeeIds'] as List,
      ),
      completionStatus: json['completionStatus'] as String,
      feedback: json['feedback'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'trainer': trainer,
      'trainingDate': trainingDate.toIso8601String(),
      'duration': duration,
      'participantEmployeeIds': participantEmployeeIds,
      'completionStatus': completionStatus,
      'feedback': feedback,
    };
  }
}
