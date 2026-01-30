class Payroll {
  final String id;
  final String employeeId;
  final double basicSalary;
  final double allowances; // HRA, Travel, Bonus
  final double deductions; // PF, Tax, Loan
  final double grossSalary;
  final double netSalary;
  final String payMonth;
  final String status; // Paid / Pending
  final DateTime? paymentDate;

  Payroll({
    required this.id,
    required this.employeeId,
    required this.basicSalary,
    required this.allowances,
    required this.deductions,
    required this.grossSalary,
    required this.netSalary,
    required this.payMonth,
    required this.status,
    this.paymentDate,
  });

  factory Payroll.fromJson(Map<String, dynamic> json) {
    return Payroll(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      basicSalary: (json['basicSalary'] as num).toDouble(),
      allowances: (json['allowances'] as num).toDouble(),
      deductions: (json['deductions'] as num).toDouble(),
      grossSalary: (json['grossSalary'] as num).toDouble(),
      netSalary: (json['netSalary'] as num).toDouble(),
      payMonth: json['payMonth'] as String,
      status: json['status'] as String,
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'basicSalary': basicSalary,
      'allowances': allowances,
      'deductions': deductions,
      'grossSalary': grossSalary,
      'netSalary': netSalary,
      'payMonth': payMonth,
      'status': status,
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }
}
