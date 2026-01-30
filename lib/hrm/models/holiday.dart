class Holiday {
  final String id;
  final String name;
  final DateTime date;
  final String type; // National / Company
  final String description;

  Holiday({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.description,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
    };
  }
}
