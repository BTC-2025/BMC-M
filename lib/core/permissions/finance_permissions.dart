// Finance Module Permissions
// Define all permission types for the Finance module

enum FinancePermission {
  // === VIEW PERMISSIONS ===
  viewFinance, // Can access Finance module
  viewInvoices, // Can view invoices list
  viewPayments, // Can view payments
  viewAccounts, // Can view chart of accounts
  viewReports, // Can view financial reports
  viewAssets, // Can view asset registry
  viewTax, // Can view tax compliance
  // === CREATE PERMISSIONS ===
  createInvoice, // Can create new invoices
  createPayment, // Can create payments
  createAccount, // Can create accounts
  createAsset, // Can register assets
  // === EDIT PERMISSIONS ===
  editInvoice, // Can edit invoices
  editPayment, // Can edit payments
  editAccount, // Can edit accounts
  editAsset, // Can edit assets
  // === DELETE PERMISSIONS ===
  deleteInvoice, // Can delete invoices
  deletePayment, // Can delete payments
  deleteAccount, // Can delete accounts
  deleteAsset, // Can delete assets
  // === APPROVE PERMISSIONS ===
  approveInvoice, // Can approve invoices
  approvePayment, // Can approve payments
  // === ADMIN PERMISSIONS ===
  manageFinanceSettings, // Can manage finance settings
  exportFinanceData, // Can export financial data
  viewAuditLog, // Can view audit logs
}

extension FinancePermissionExtension on FinancePermission {
  /// Convert permission to string key for storage/checking
  String get key {
    switch (this) {
      // View permissions
      case FinancePermission.viewFinance:
        return 'finance.view';
      case FinancePermission.viewInvoices:
        return 'finance.invoices.view';
      case FinancePermission.viewPayments:
        return 'finance.payments.view';
      case FinancePermission.viewAccounts:
        return 'finance.accounts.view';
      case FinancePermission.viewReports:
        return 'finance.reports.view';
      case FinancePermission.viewAssets:
        return 'finance.assets.view';
      case FinancePermission.viewTax:
        return 'finance.tax.view';

      // Create permissions
      case FinancePermission.createInvoice:
        return 'finance.invoices.create';
      case FinancePermission.createPayment:
        return 'finance.payments.create';
      case FinancePermission.createAccount:
        return 'finance.accounts.create';
      case FinancePermission.createAsset:
        return 'finance.assets.create';

      // Edit permissions
      case FinancePermission.editInvoice:
        return 'finance.invoices.edit';
      case FinancePermission.editPayment:
        return 'finance.payments.edit';
      case FinancePermission.editAccount:
        return 'finance.accounts.edit';
      case FinancePermission.editAsset:
        return 'finance.assets.edit';

      // Delete permissions
      case FinancePermission.deleteInvoice:
        return 'finance.invoices.delete';
      case FinancePermission.deletePayment:
        return 'finance.payments.delete';
      case FinancePermission.deleteAccount:
        return 'finance.accounts.delete';
      case FinancePermission.deleteAsset:
        return 'finance.assets.delete';

      // Approve permissions
      case FinancePermission.approveInvoice:
        return 'finance.invoices.approve';
      case FinancePermission.approvePayment:
        return 'finance.payments.approve';

      // Admin permissions
      case FinancePermission.manageFinanceSettings:
        return 'finance.settings.manage';
      case FinancePermission.exportFinanceData:
        return 'finance.data.export';
      case FinancePermission.viewAuditLog:
        return 'finance.audit.view';
    }
  }

  /// Human-readable description
  String get description {
    switch (this) {
      // View permissions
      case FinancePermission.viewFinance:
        return 'View Finance Module';
      case FinancePermission.viewInvoices:
        return 'View Invoices';
      case FinancePermission.viewPayments:
        return 'View Payments';
      case FinancePermission.viewAccounts:
        return 'View Accounts';
      case FinancePermission.viewReports:
        return 'View Financial Reports';
      case FinancePermission.viewAssets:
        return 'View Assets';
      case FinancePermission.viewTax:
        return 'View Tax Information';

      // Create permissions
      case FinancePermission.createInvoice:
        return 'Create Invoices';
      case FinancePermission.createPayment:
        return 'Create Payments';
      case FinancePermission.createAccount:
        return 'Create Accounts';
      case FinancePermission.createAsset:
        return 'Register Assets';

      // Edit permissions
      case FinancePermission.editInvoice:
        return 'Edit Invoices';
      case FinancePermission.editPayment:
        return 'Edit Payments';
      case FinancePermission.editAccount:
        return 'Edit Accounts';
      case FinancePermission.editAsset:
        return 'Edit Assets';

      // Delete permissions
      case FinancePermission.deleteInvoice:
        return 'Delete Invoices';
      case FinancePermission.deletePayment:
        return 'Delete Payments';
      case FinancePermission.deleteAccount:
        return 'Delete Accounts';
      case FinancePermission.deleteAsset:
        return 'Delete Assets';

      // Approve permissions
      case FinancePermission.approveInvoice:
        return 'Approve Invoices';
      case FinancePermission.approvePayment:
        return 'Approve Payments';

      // Admin permissions
      case FinancePermission.manageFinanceSettings:
        return 'Manage Finance Settings';
      case FinancePermission.exportFinanceData:
        return 'Export Financial Data';
      case FinancePermission.viewAuditLog:
        return 'View Audit Logs';
    }
  }

  /// Permission category for grouping
  String get category {
    if (key.contains('.view')) return 'View';
    if (key.contains('.create')) return 'Create';
    if (key.contains('.edit')) return 'Edit';
    if (key.contains('.delete')) return 'Delete';
    if (key.contains('.approve')) return 'Approve';
    if (key.contains('.manage') ||
        key.contains('.export') ||
        key.contains('.audit')) {
      return 'Admin';
    }
    return 'Other';
  }
}

/// Predefined permission sets for common roles
class FinanceRoles {
  /// Finance Administrator - Full access
  static List<String> get admin =>
      FinancePermission.values.map((p) => p.key).toList();

  /// Finance Viewer - Read-only access
  static List<String> get viewer => [
    FinancePermission.viewFinance.key,
    FinancePermission.viewInvoices.key,
    FinancePermission.viewPayments.key,
    FinancePermission.viewAccounts.key,
    FinancePermission.viewReports.key,
    FinancePermission.viewAssets.key,
    FinancePermission.viewTax.key,
  ];

  /// Accountant - Can create and edit, but not delete or approve
  static List<String> get accountant => [
    ...viewer,
    FinancePermission.createInvoice.key,
    FinancePermission.editInvoice.key,
    FinancePermission.createPayment.key,
    FinancePermission.editPayment.key,
    FinancePermission.createAccount.key,
    FinancePermission.editAccount.key,
    FinancePermission.createAsset.key,
    FinancePermission.editAsset.key,
  ];

  /// Finance Manager - Can approve but not delete
  static List<String> get manager => [
    ...accountant,
    FinancePermission.approveInvoice.key,
    FinancePermission.approvePayment.key,
    FinancePermission.viewAuditLog.key,
  ];
}
