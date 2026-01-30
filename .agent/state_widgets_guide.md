# State Widgets Usage Guide

## Quick Start

These standardized widgets replace inconsistent loading/error/empty states across the app.

### Import

```dart
import 'package:erp_app/common/widgets/states.dart';
```

---

## 1. LoadingState

**Replace this:**
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return const Center(child: CircularProgressIndicator());
}
```

**With this:**
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return const LoadingState(message: 'Loading leads...');
}
```

**Optional parameters:**
- `message`: String? - Optional loading message
- `color`: Color? - Custom spinner color

---

## 2. EmptyState

**Replace this:**
```dart
if (snapshot.data!.isEmpty) {
  return const Center(child: Text('No leads found'));
}
```

**With this:**
```dart
if (snapshot.data!.isEmpty) {
  return EmptyState(
    title: 'No Leads Found',
    subtitle: 'Get started by adding a new lead to your pipeline.',
    icon: Icons.person_add_rounded,
    onAction: _navigateToAddLead,
    actionLabel: 'Add Lead',
  );
}
```

**Optional parameters:**
- `title`: String - Main heading (default: 'No Data Available')
- `subtitle`: String - Description text
- `icon`: IconData - Icon to display (default: Icons.inbox_rounded)
- `onAction`: VoidCallback? - Action button callback
- `actionLabel`: String? - Action button text
- `iconColor`: Color? - Custom icon color

---

## 3. ErrorState

**Replace this:**
```dart
if (snapshot.hasError) {
  return Center(child: Text('Error: ${snapshot.error}'));
}
```

**With this:**
```dart
if (snapshot.hasError) {
  return ErrorState(
    message: 'Failed to load leads. Please try again.',
    onRetry: _refreshLeads,
  );
}
```

**Optional parameters:**
- `title`: String - Error heading (default: 'Oops!')
- `message`: String - Error description (required)
- `onRetry`: VoidCallback? - Retry button callback
- `icon`: IconData - Error icon (default: Icons.error_outline_rounded)

---

## Real-World Example

### Before (Inconsistent):
```dart
FutureBuilder<List<Lead>>(
  future: _leadsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No leads found'));
    }
    
    return ListView.builder(...);
  },
);
```

### After (Standardized):
```dart
FutureBuilder<List<Lead>>(
  future: _leadsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingState(message: 'Loading leads...');
    }
    if (snapshot.hasError) {
      return ErrorState(
        message: 'Failed to load leads. Please try again.',
        onRetry: _refreshLeads,
      );
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return EmptyState(
        title: 'No Leads Found',
        subtitle: 'Get started by adding a new lead.',
        icon: Icons.person_add_rounded,
        onAction: _navigateToAddLead,
        actionLabel: 'Add Lead',
      );
    }
    
    return ListView.builder(...);
  },
);
```

---

## Benefits

✅ **Consistent UX** - Same look and feel across all modules  
✅ **Less Code** - No need to rebuild loading/error/empty UI  
✅ **Easier Maintenance** - Update once, applies everywhere  
✅ **Better Accessibility** - Standardized semantics and colors  
✅ **Faster Development** - Just import and use

---

## Where to Use

Apply these widgets in:
- ✅ **CRM**: leads_screen.dart, customers_screen.dart
- ✅ **Inventory**: inventory_items_list.dart, inventory_suppliers.dart
- ✅ **Manufacturing**: machine_status_screen.dart, bom_list_screen.dart
- ✅ **Finance**: billing_invoices_screen.dart, payables_screen.dart
- ✅ **HRM**: employees_screen.dart, attendance_screen.dart
- ✅ **SCM**: suppliers_screen.dart, shipments_screen.dart
- ✅ **Projects**: projects_screen.dart, project_tasks_screen.dart

---

## Migration Strategy

1. **New Features**: Use these widgets from day one
2. **Bug Fixes**: Replace old patterns when fixing related bugs
3. **Refactoring**: Gradually update existing screens during sprints
4. **Don't Rush**: No need to update everything at once

---

## Customization

If you need module-specific styling, extend these widgets:

```dart
class CrmEmptyState extends EmptyState {
  const CrmEmptyState({
    super.key,
    required super.title,
    required super.subtitle,
    super.onAction,
    super.actionLabel,
  }) : super(
    icon: Icons.people_outline_rounded,
    iconColor: Color(0xFF2E3192), // CRM brand color
  );
}
```

---

**Last Updated**: 2026-01-23  
**Status**: Ready for production use
