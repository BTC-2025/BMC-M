import 'package:flutter/material.dart';

enum CustomerStatus { active, inactive, churned }

extension CustomerStatusExtension on CustomerStatus {
  String get label {
    switch (this) {
      case CustomerStatus.active:
        return 'Active';
      case CustomerStatus.inactive:
        return 'Inactive';
      case CustomerStatus.churned:
        return 'Churned';
    }
  }

  Color get color {
    switch (this) {
      case CustomerStatus.active:
        return Colors.green;
      case CustomerStatus.inactive:
        return Colors.grey;
      case CustomerStatus.churned:
        return Colors.red;
    }
  }
}

class Customer {
  final String id;
  final String name;
  final String company;
  final String email;
  final String phone;
  final CustomerStatus status;
  final DateTime joinDate;
  final double totalRevenue; // LTV
  final String address;
  final String accountManagerId;
  final List<String> tags;

  Customer({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.status,
    required this.joinDate,
    required this.totalRevenue,
    required this.address,
    required this.accountManagerId,
    this.tags = const [],
  });

  String get initials =>
      name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '';
}
