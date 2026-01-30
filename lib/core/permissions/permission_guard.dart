import 'package:flutter/material.dart';
import 'permission.dart';
import 'permission_service.dart';

// Simple widget to wrap components that require specific permissions
class PermissionGuard extends StatelessWidget {
  final AppPermission permission;
  final Widget child;
  final Widget? fallback;

  const PermissionGuard({
    super.key,
    required this.permission,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, you would use Provider.of<PermissionService>(context)
    // For now, we simulate with a singleton or static instance logic
    final permissionService = PermissionService(); // Placeholder for DI

    if (permissionService.hasPermission(permission)) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}
