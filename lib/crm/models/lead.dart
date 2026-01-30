import 'package:flutter/material.dart';
import 'activity_note.dart';

enum LeadStatus { newLead, contacted, qualified, negotiation, won, lost }

extension LeadStatusExtension on LeadStatus {
  String get label {
    switch (this) {
      case LeadStatus.newLead:
        return 'New Lead';
      case LeadStatus.contacted:
        return 'Contacted';
      case LeadStatus.qualified:
        return 'Qualified';
      case LeadStatus.negotiation:
        return 'Negotiation';
      case LeadStatus.won:
        return 'Won';
      case LeadStatus.lost:
        return 'Lost';
    }
  }

  Color get color {
    switch (this) {
      case LeadStatus.newLead:
        return Colors.blue;
      case LeadStatus.contacted:
        return Colors.orange;
      case LeadStatus.qualified:
        return Colors.purple;
      case LeadStatus.negotiation:
        return Colors.amber;
      case LeadStatus.won:
        return Colors.green;
      case LeadStatus.lost:
        return Colors.red;
    }
  }
}

class Lead {
  final String id;
  final String firstName;
  final String lastName;
  final String company;
  final String email;
  final String phone;
  final double value;
  final LeadStatus status;
  final String source; // e.g., Website, Referral, Cold Call
  final DateTime createdAt;
  final DateTime lastContacted;
  final String ownerId; // ID of the sales rep
  final List<String> tags;
  final String notes; // Kept for backward compatibility or simple summary
  final List<Activity> activities;
  final List<Note> notesList;

  Lead({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.email,
    required this.phone,
    required this.value,
    required this.status,
    required this.source,
    required this.createdAt,
    required this.lastContacted,
    required this.ownerId,
    this.tags = const [],
    this.notes = '',
    this.activities = const [],
    this.notesList = const [],
  });

  String get fullName => '$firstName $lastName';
  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();
}
