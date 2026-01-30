class HrExpense {
  final String id;
  final String employeeId;
  final String expenseType;
  final double amount;
  final DateTime date;
  final String? receiptUrl;
  final String status; // Pending / Approved / Rejected
  final String? approvedBy;

  HrExpense({
    required this.id,
    required this.employeeId,
    required this.expenseType,
    required this.amount,
    required this.date,
    this.receiptUrl,
    required this.status,
    this.approvedBy,
  });

  factory HrExpense.fromJson(Map<String, dynamic> json) {
    return HrExpense(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      expenseType: json['expenseType'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      receiptUrl: json['receiptUrl'] as String?,
      status: json['status'] as String,
      approvedBy: json['approvedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'expenseType': expenseType,
      'amount': amount,
      'date': date.toIso8601String(),
      'receiptUrl': receiptUrl,
      'status': status,
      'approvedBy': approvedBy,
    };
  }
}
