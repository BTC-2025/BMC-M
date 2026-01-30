enum ExpenseCategory { travel, material, software, contractor, other }

extension ExpenseCategoryExtension on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.travel:
        return 'Travel';
      case ExpenseCategory.material:
        return 'Material';
      case ExpenseCategory.software:
        return 'Software';
      case ExpenseCategory.contractor:
        return 'Contractor';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

class ProjectExpense {
  final String id;
  final String projectId;
  final String userId; // Who incurred/logged this
  final String description;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final String? attachmentUrl;

  ProjectExpense({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    this.attachmentUrl,
  });
}
