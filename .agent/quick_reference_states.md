# 🎴 Quick Reference: State Widgets

> **Print this and keep it near your desk!**

---

## 📦 Import

```dart
import 'package:erp_app/common/widgets/states.dart';
```

---

## 🔄 LoadingState

**When to use**: Data is being fetched

```dart
return const LoadingState(
  message: 'Loading products...',  // Optional
);
```

**Customization**:
```dart
LoadingState(
  message: 'Syncing data...',
  color: Colors.blue,  // Custom spinner color
);
```

---

## 📭 EmptyState

**When to use**: No data to display

```dart
return EmptyState(
  title: 'No Products Found',
  subtitle: 'Add your first product to get started.',
  icon: Icons.inventory_rounded,
  onAction: _addProduct,
  actionLabel: 'Add Product',
);
```

**Minimal version**:
```dart
return const EmptyState(
  title: 'No Data',
  subtitle: 'Nothing to show here.',
);
```

---

## ❌ ErrorState

**When to use**: Something went wrong

```dart
return ErrorState(
  message: 'Failed to load data. Check your connection.',
  onRetry: _refreshData,
);
```

**Custom error**:
```dart
return ErrorState(
  title: 'Oops!',
  message: snapshot.error.toString(),
  onRetry: _refreshData,
  icon: Icons.cloud_off_rounded,
);
```

---

## 🎯 Complete Example

```dart
FutureBuilder<List<Product>>(
  future: _productsFuture,
  builder: (context, snapshot) {
    // Loading
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingState(message: 'Loading...');
    }
    
    // Error
    if (snapshot.hasError) {
      return ErrorState(
        message: 'Failed to load products',
        onRetry: _refresh,
      );
    }
    
    // Empty
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return EmptyState(
        title: 'No Products',
        subtitle: 'Add products to your inventory',
        onAction: _addProduct,
        actionLabel: 'Add Product',
      );
    }
    
    // Success
    return ListView.builder(...);
  },
);
```

---

## 🎨 Module Colors

Use module-specific colors for consistency:

```dart
// CRM
iconColor: const Color(0xFF2E3192)

// Finance
iconColor: const Color(0xFF00C853)

// Manufacturing
iconColor: const Color(0xFFFF6D00)

// Inventory
iconColor: const Color(0xFF3B4CCA)

// HRM
iconColor: const Color(0xFF9C27B0)

// SCM
iconColor: const Color(0xFF1E88E5)
```

---

## ✅ Checklist

Before committing:
- [ ] Imported `states.dart`
- [ ] Used `LoadingState` for loading
- [ ] Used `ErrorState` with retry
- [ ] Used `EmptyState` with action (if applicable)
- [ ] Tested all three states
- [ ] Added appropriate messages

---

**Version**: 1.0  
**Last Updated**: 2026-01-23
