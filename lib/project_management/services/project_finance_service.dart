import '../models/expense.dart';

class ProjectFinanceService {
  static final ProjectFinanceService _instance =
      ProjectFinanceService._internal();

  factory ProjectFinanceService() {
    return _instance;
  }

  ProjectFinanceService._internal();

  final List<ProjectExpense> _expenses = [
    // Mock for Project 1
    ProjectExpense(
      id: 'exp_1',
      projectId: 'proj_1',
      userId: 'emp_1',
      description: 'Figma Professional License (Yearly)',
      amount: 144.0,
      date: DateTime.now().subtract(const Duration(days: 30)),
      category: ExpenseCategory.software,
    ),
    ProjectExpense(
      id: 'exp_2',
      projectId: 'proj_1',
      userId: 'emp_2',
      description: 'Stock Photos for Hero Section',
      amount: 50.0,
      date: DateTime.now().subtract(const Duration(days: 15)),
      category: ExpenseCategory.material,
    ),
  ];

  Future<List<ProjectExpense>> getExpensesByProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _expenses.where((e) => e.projectId == projectId).toList();
  }

  Future<void> addExpense(ProjectExpense expense) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _expenses.add(expense);
  }

  // Helper to calculate total project burn (Expenses + Labor)
  // Ideally labor cost comes from TimeEntries * HourlyRate.
  // We can add a simple estimator here.
  Future<double> calculateTotalCost(
    String projectId, {
    double defaultHourlyRate = 50.0,
  }) async {
    // 1. Sum Expenses
    final expenses = await getExpensesByProject(projectId);
    final expenseTotal = expenses.fold(0.0, (sum, e) => sum + e.amount);

    // 2. Sum Labor (This would usually call TimeTrackingService)
    // For now we will mock it or call it if we want full integration
    // Let's Keep it simple and just return expenseTotal for this specific service
    // In the UI we can combine them.
    return expenseTotal;
  }
}
