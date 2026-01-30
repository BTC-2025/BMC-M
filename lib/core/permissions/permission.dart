enum AppPermission {
  // Inventory
  viewInventory,
  manageInventory,
  deleteInventory,

  // CRM
  viewCRM,
  manageCRM,

  // Finance
  viewFinance,
  manageFinance,

  // Admin
  accessSettings,
  manageUsers,
}

class UserRole {
  final String name;
  final Set<AppPermission> permissions;

  UserRole({required this.name, required this.permissions});

  static final UserRole admin = UserRole(
    name: 'Admin',
    permissions: AppPermission.values.toSet(),
  );

  static final UserRole manager = UserRole(
    name: 'Manager',
    permissions: {
      AppPermission.viewInventory,
      AppPermission.manageInventory,
      AppPermission.viewCRM,
      AppPermission.manageCRM,
      AppPermission.viewFinance,
      AppPermission.accessSettings,
    },
  );

  static final UserRole staff = UserRole(
    name: 'Staff',
    permissions: {
      AppPermission.viewInventory,
      AppPermission.viewCRM,
      AppPermission.viewFinance,
    },
  );
}
