# 🧭 Phase 2: Type-Safe Navigation (10-14 Days)

**Priority**: ⭐⭐⭐⭐⭐ HIGH  
**Timeline**: After Phase 1 (Permissions)  
**Duration**: 10-14 days  
**Dependencies**: Permission system must be complete

---

## 🎯 Why After Permissions?

### Strategic Reasoning:

1. **Navigation helpers can enforce permissions**
   - Check permissions before navigation
   - Redirect to login/unauthorized
   - Prevent unauthorized route access

2. **Fewer crash vectors**
   - Type-safe arguments
   - Compile-time validation
   - No runtime string errors

3. **Cleaner intent-based routing**
   - `AppNavigator.openInvoice(invoice)` vs `Navigator.pushNamed('/invoice')`
   - Self-documenting code
   - Better IDE support

4. **Builds on Phase 1**
   - Permissions already defined
   - Guards already in place
   - Navigation can leverage both

---

## 📋 Implementation Strategy

### Approach: **Gradual Type-Safe Layer**

**Philosophy**: Add type safety WITHOUT breaking existing code

**Pattern**:
```dart
// Old way (still works)
Navigator.pushNamed(context, RouteNames.invoice);

// New way (preferred)
AppNavigator.openInvoice(context, invoice);
```

**Migration**: Use new way for new code, migrate old code opportunistically

---

## 🏗️ Three-Layer Implementation

### Layer 1: Navigation Service (Days 1-4)
### Layer 2: Typed Routes (Days 5-8)
### Layer 3: Permission Integration (Days 9-12)
### Testing & Migration (Days 13-14)

---

## 📅 Detailed Implementation Plan

### **Days 1-2: Foundation - Navigation Service**

#### Step 1: Create Base Navigation Service

Create `lib/navigation/navigation_service.dart`:

```dart
import 'package:flutter/material.dart';
import '../core/permissions/permission_service.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();
  
  // Global navigator key for navigation without context
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // Get current context
  BuildContext? get context => navigatorKey.currentContext;
  
  // Get current navigator state
  NavigatorState? get navigator => navigatorKey.currentState;
  
  // Push route
  Future<T?> push<T>(Route<T> route) async {
    return navigator?.push(route);
  }
  
  // Push named route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return navigator?.pushNamed<T>(routeName, arguments: arguments);
  }
  
  // Push replacement
  Future<T?> pushReplacement<T, TO>(Route<T> route, {TO? result}) async {
    return navigator?.pushReplacement(route, result: result);
  }
  
  // Pop
  void pop<T>([T? result]) {
    navigator?.pop(result);
  }
  
  // Pop until
  void popUntil(RoutePredicate predicate) {
    navigator?.popUntil(predicate);
  }
  
  // Can pop
  bool canPop() {
    return navigator?.canPop() ?? false;
  }
  
  // Push with permission check
  Future<T?> pushWithPermission<T>({
    required String permission,
    required Route<T> route,
    VoidCallback? onUnauthorized,
  }) async {
    if (PermissionService().hasPermission(permission)) {
      return push(route);
    } else {
      onUnauthorized?.call();
      _showUnauthorizedDialog();
      return null;
    }
  }
  
  // Show unauthorized dialog
  void _showUnauthorizedDialog() {
    if (context == null) return;
    
    showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text('Access Denied'),
        content: const Text('You don\'t have permission to access this page.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
```

#### Step 2: Update App to Use Navigation Service

Update `lib/app.dart`:

```dart
import 'navigation/navigation_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService().navigatorKey, // Add this
      onGenerateRoute: AppRouter.generateRoute,
      // ... rest of config
    );
  }
}
```

---

### **Days 3-4: Typed Route Arguments**

#### Step 1: Create Route Arguments Classes

Create `lib/navigation/route_arguments.dart`:

```dart
// Base class for all route arguments
abstract class RouteArguments {
  const RouteArguments();
}

// Invoice detail arguments
class InvoiceDetailArguments extends RouteArguments {
  final String invoiceId;
  final bool isEditable;
  
  const InvoiceDetailArguments({
    required this.invoiceId,
    this.isEditable = false,
  });
}

// Lead detail arguments
class LeadDetailArguments extends RouteArguments {
  final String leadId;
  final String? source; // Where user came from
  
  const LeadDetailArguments({
    required this.leadId,
    this.source,
  });
}

// Product detail arguments
class ProductDetailArguments extends RouteArguments {
  final String productId;
  final bool showStock;
  
  const ProductDetailArguments({
    required this.productId,
    this.showStock = true,
  });
}

// Payment arguments
class PaymentArguments extends RouteArguments {
  final String? invoiceId; // Optional - for invoice payment
  final double? amount;
  
  const PaymentArguments({
    this.invoiceId,
    this.amount,
  });
}

// Add more as needed...
```

#### Step 2: Update Screens to Use Typed Arguments

Example: `lib/finance/screens/invoices/invoice_detail_screen.dart`:

```dart
class InvoiceDetailScreen extends StatelessWidget {
  // Accept typed arguments
  final InvoiceDetailArguments arguments;
  
  const InvoiceDetailScreen({
    super.key,
    required this.arguments,
  });
  
  // Factory constructor for route
  static Route route(InvoiceDetailArguments arguments) {
    return MaterialPageRoute(
      builder: (_) => InvoiceDetailScreen(arguments: arguments),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // Use arguments.invoiceId, arguments.isEditable, etc.
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice ${arguments.invoiceId}'),
      ),
      // ... rest of screen
    );
  }
}
```

---

### **Days 5-8: App Navigator - Type-Safe Helpers**

#### Step 1: Create App Navigator

Create `lib/navigation/app_navigator.dart`:

```dart
import 'package:flutter/material.dart';
import 'navigation_service.dart';
import 'route_arguments.dart';
import '../core/permissions/permission_service.dart';
import '../core/permissions/finance_permissions.dart';
import '../core/permissions/crm_permissions.dart';

/// Type-safe navigation helpers
/// Use these instead of Navigator.pushNamed
class AppNavigator {
  static final _nav = NavigationService();
  static final _permissions = PermissionService();
  
  // ==================== FINANCE ====================
  
  /// Navigate to Finance module
  static Future<void> openFinance(BuildContext context) async {
    if (!_permissions.hasPermission(FinancePermission.viewFinance.key)) {
      _showUnauthorized(context);
      return;
    }
    
    await Navigator.pushNamed(context, RouteNames.finance);
  }
  
  /// Navigate to Invoice detail
  static Future<void> openInvoice(
    BuildContext context, {
    required String invoiceId,
    bool isEditable = false,
  }) async {
    if (!_permissions.hasPermission(FinancePermission.viewInvoices.key)) {
      _showUnauthorized(context);
      return;
    }
    
    final arguments = InvoiceDetailArguments(
      invoiceId: invoiceId,
      isEditable: isEditable,
    );
    
    await _nav.push(InvoiceDetailScreen.route(arguments));
  }
  
  /// Navigate to create invoice
  static Future<bool?> createInvoice(BuildContext context) async {
    if (!_permissions.hasPermission(FinancePermission.createInvoice.key)) {
      _showUnauthorized(context);
      return null;
    }
    
    return await _nav.push<bool>(CreateInvoiceScreen.route());
  }
  
  /// Navigate to payment screen
  static Future<void> openPayment(
    BuildContext context, {
    String? invoiceId,
    double? amount,
  }) async {
    if (!_permissions.hasPermission(FinancePermission.viewPayments.key)) {
      _showUnauthorized(context);
      return;
    }
    
    final arguments = PaymentArguments(
      invoiceId: invoiceId,
      amount: amount,
    );
    
    await _nav.push(PaymentScreen.route(arguments));
  }
  
  // ==================== CRM ====================
  
  /// Navigate to CRM module
  static Future<void> openCRM(BuildContext context) async {
    if (!_permissions.hasPermission(CrmPermission.viewCrm.key)) {
      _showUnauthorized(context);
      return;
    }
    
    await Navigator.pushNamed(context, RouteNames.crm);
  }
  
  /// Navigate to Lead detail
  static Future<void> openLead(
    BuildContext context, {
    required String leadId,
    String? source,
  }) async {
    if (!_permissions.hasPermission(CrmPermission.viewLeads.key)) {
      _showUnauthorized(context);
      return;
    }
    
    final arguments = LeadDetailArguments(
      leadId: leadId,
      source: source,
    );
    
    await _nav.push(LeadDetailScreen.route(arguments));
  }
  
  /// Navigate to create lead
  static Future<bool?> createLead(BuildContext context) async {
    if (!_permissions.hasPermission(CrmPermission.createLead.key)) {
      _showUnauthorized(context);
      return null;
    }
    
    return await _nav.push<bool>(CreateLeadScreen.route());
  }
  
  // ==================== INVENTORY ====================
  
  /// Navigate to Inventory module
  static Future<void> openInventory(BuildContext context) async {
    if (!_permissions.hasPermission(InventoryPermission.viewInventory.key)) {
      _showUnauthorized(context);
      return;
    }
    
    await Navigator.pushNamed(context, RouteNames.inventory);
  }
  
  /// Navigate to Product detail
  static Future<void> openProduct(
    BuildContext context, {
    required String productId,
    bool showStock = true,
  }) async {
    if (!_permissions.hasPermission(InventoryPermission.viewProducts.key)) {
      _showUnauthorized(context);
      return;
    }
    
    final arguments = ProductDetailArguments(
      productId: productId,
      showStock: showStock,
    );
    
    await _nav.push(ProductDetailScreen.route(arguments));
  }
  
  // ==================== COMMON ====================
  
  /// Navigate to Settings
  static Future<void> openSettings(BuildContext context) async {
    await Navigator.pushNamed(context, RouteNames.settings);
  }
  
  /// Navigate to Dashboard
  static Future<void> openDashboard(BuildContext context) async {
    await Navigator.pushNamed(context, RouteNames.dashboard);
  }
  
  /// Go back
  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
  
  /// Go back to specific route
  static void goBackTo(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      (route) => route.settings.name == routeName,
    );
  }
  
  // ==================== HELPERS ====================
  
  /// Show unauthorized dialog
  static void _showUnauthorized(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Access Denied'),
        content: const Text(
          'You don\'t have permission to access this page.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  /// Check if user can navigate to route
  static bool canNavigateTo(String permission) {
    return _permissions.hasPermission(permission);
  }
}
```

---

### **Days 9-10: Deep Links & URL Strategy**

#### Step 1: Create Deep Link Handler

Create `lib/navigation/deep_link_handler.dart`:

```dart
import 'package:flutter/material.dart';
import 'app_navigator.dart';

class DeepLinkHandler {
  /// Handle deep link URL
  static Future<void> handleDeepLink(
    BuildContext context,
    String url,
  ) async {
    final uri = Uri.parse(url);
    final path = uri.path;
    final params = uri.queryParameters;
    
    // Parse and route
    if (path.startsWith('/finance/invoice/')) {
      final invoiceId = path.split('/').last;
      await AppNavigator.openInvoice(
        context,
        invoiceId: invoiceId,
        isEditable: params['edit'] == 'true',
      );
    } else if (path.startsWith('/crm/lead/')) {
      final leadId = path.split('/').last;
      await AppNavigator.openLead(
        context,
        leadId: leadId,
        source: params['source'],
      );
    } else if (path.startsWith('/inventory/product/')) {
      final productId = path.split('/').last;
      await AppNavigator.openProduct(
        context,
        productId: productId,
        showStock: params['stock'] != 'false',
      );
    }
    // Add more routes as needed
  }
  
  /// Generate deep link URL
  static String generateDeepLink({
    required String path,
    Map<String, String>? params,
  }) {
    final uri = Uri(
      scheme: 'erp',
      host: 'app',
      path: path,
      queryParameters: params,
    );
    return uri.toString();
  }
}
```

---

### **Days 11-12: Migration & Refactoring**

#### Step 1: Create Migration Guide

Create `.agent/NAVIGATION_MIGRATION.md`:

```markdown
# Navigation Migration Guide

## Old Pattern → New Pattern

### Before (String-based)
```dart
Navigator.pushNamed(
  context,
  '/finance/invoice',
  arguments: {'id': invoiceId},
);
```

### After (Type-safe)
```dart
AppNavigator.openInvoice(
  context,
  invoiceId: invoiceId,
);
```

## Benefits
- ✅ Compile-time safety
- ✅ Permission checks built-in
- ✅ Better IDE support
- ✅ Self-documenting
- ✅ Easier refactoring

## Migration Strategy
1. Use new pattern for all new code
2. Migrate high-traffic screens first
3. Migrate during bug fixes
4. No rush - both patterns work
```

#### Step 2: Migrate High-Traffic Screens

**Priority screens to migrate**:
1. Dashboard → Finance
2. Dashboard → CRM
3. Lead list → Lead detail
4. Invoice list → Invoice detail
5. Product list → Product detail

**Example migration**:

```dart
// OLD
onTap: () {
  Navigator.pushNamed(
    context,
    '/finance/invoice',
    arguments: {'id': invoice.id},
  );
}

// NEW
onTap: () {
  AppNavigator.openInvoice(
    context,
    invoiceId: invoice.id,
  );
}
```

---

### **Days 13-14: Testing & Documentation**

#### Day 13: Comprehensive Testing

**Test Matrix**:

| Navigation | Permission | Expected Result |
|------------|------------|-----------------|
| openFinance | Has permission | Navigate ✅ |
| openFinance | No permission | Show dialog ❌ |
| openInvoice | Has permission | Navigate ✅ |
| openInvoice | No permission | Show dialog ❌ |
| createInvoice | Has permission | Navigate ✅ |
| createInvoice | No permission | Show dialog ❌ |

**Test Scenarios**:
1. ✅ Navigation with permission
2. ✅ Navigation without permission
3. ✅ Typed arguments passed correctly
4. ✅ Deep links work
5. ✅ Back navigation works
6. ✅ No runtime crashes

#### Day 14: Documentation

Create `lib/navigation/README.md`:

```markdown
# Navigation System

## Overview
Type-safe navigation with built-in permission checks.

## Usage

### Basic Navigation
```dart
// Navigate to module
AppNavigator.openFinance(context);

// Navigate to detail screen
AppNavigator.openInvoice(
  context,
  invoiceId: '123',
  isEditable: true,
);
```

### With Result
```dart
final created = await AppNavigator.createInvoice(context);
if (created == true) {
  // Refresh list
}
```

### Deep Links
```dart
DeepLinkHandler.handleDeepLink(
  context,
  'erp://app/finance/invoice/123?edit=true',
);
```

## Adding New Routes

1. Define arguments class
2. Add route method to screen
3. Add helper to AppNavigator
4. Add permission check
5. Test thoroughly
```

---

## 📊 Success Metrics

### Must Achieve:

- [ ] **100% permission integration** - All navigations check permissions
- [ ] **Zero string-based routes** - In new code
- [ ] **Compile-time safety** - No runtime route errors
- [ ] **Deep link support** - URL-based navigation works
- [ ] **Clear error messages** - Users understand denials
- [ ] **Tested with 10+ routes** - Finance + CRM covered

---

## 🎯 Deliverables

### Code Files:
1. ✅ `lib/navigation/navigation_service.dart`
2. ✅ `lib/navigation/route_arguments.dart`
3. ✅ `lib/navigation/app_navigator.dart`
4. ✅ `lib/navigation/deep_link_handler.dart`
5. ✅ `lib/navigation/README.md`
6. ✅ Updated screens with typed arguments
7. ✅ Migration guide

### Documentation:
1. ✅ Navigation system README
2. ✅ Migration guide
3. ✅ Deep link documentation
4. ✅ Testing checklist

---

## 🚀 After Type-Safe Navigation

### Benefits Unlocked:

✅ **Compile-time safety** - No more runtime route errors  
✅ **Permission-aware** - Security built into navigation  
✅ **Better DX** - IDE autocomplete and type hints  
✅ **Self-documenting** - Clear intent in code  
✅ **Easier refactoring** - Find all usages  
✅ **Deep link ready** - URL-based navigation  

### Next Phase:

**Phase 3: Test Coverage** (Weeks 7-8)
- Unit tests for navigation
- Integration tests for flows
- Permission tests
- Widget tests

---

## 💡 Pro Tips

### Development Tips:
1. **Start with one module** - Finance or CRM
2. **Migrate incrementally** - No big bang
3. **Test as you go** - Don't wait
4. **Document patterns** - Help team
5. **Use IDE refactoring** - Find all usages

### Testing Tips:
1. **Test permission checks** - Both granted and denied
2. **Test argument passing** - Correct data flows
3. **Test back navigation** - Proper stack management
4. **Test deep links** - URL parsing works
5. **Test error cases** - Graceful failures

### Migration Tips:
1. **High-traffic first** - Most impact
2. **During bug fixes** - Natural opportunity
3. **New features** - Always use new pattern
4. **Document changes** - Help team understand
5. **Pair program** - Share knowledge

---

## ⚠️ Common Pitfalls

### Avoid These:
❌ **Mixing patterns** - Use one consistently  
❌ **Skipping permissions** - Always check  
❌ **Complex arguments** - Keep simple  
❌ **Deep nesting** - Flatten when possible  
❌ **Forgetting tests** - Test navigation flows  

### Do These:
✅ **Consistent naming** - `open*`, `create*`, `edit*`  
✅ **Permission checks** - Every navigation  
✅ **Typed arguments** - No maps or dynamic  
✅ **Clear intent** - Method names explain purpose  
✅ **Test thoroughly** - All paths  

---

## 🎉 Expected Outcome

After 14 days, you'll have:

✅ **Type-safe navigation system**  
✅ **Permission-integrated routing**  
✅ **Deep link support**  
✅ **Migrated high-traffic screens**  
✅ **Clear documentation**  
✅ **Testing strategy**  

**Impact**: Fewer crashes, better security ⭐⭐⭐⭐⭐  
**Confidence**: Production-ready  
**Next**: Add test coverage  

---

**Start Date**: After Phase 1 (Permissions)  
**Duration**: 10-14 days  
**Priority**: HIGH  
**Status**: Ready to implement  

**Let's build crash-proof navigation! 🧭**
