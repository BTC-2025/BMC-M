enum ActivityType { call, email, meeting, note, statusChange }

class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final ActivityType type;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });
}

class Note {
  final String id;
  final String content;
  final DateTime timestamp;
  final String authorName;

  Note({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.authorName,
  });
}
