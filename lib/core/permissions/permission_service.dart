import 'permission.dart';

class PermissionService {
  // Simulate a logged-in user with a role
  // In a real app, this would come from an AuthService/UserProvider
  UserRole _currentRole = UserRole.admin;

  void setRole(UserRole role) {
    _currentRole = role;
  }

  bool hasPermission(AppPermission permission) {
    return _currentRole.permissions.contains(permission);
  }

  bool hasAnyPermission(List<AppPermission> permissions) {
    return permissions.any((p) => _currentRole.permissions.contains(p));
  }
}
