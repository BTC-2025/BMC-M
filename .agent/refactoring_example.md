# Example: Refactoring machine_status_screen.dart

## Before (Current Implementation)

```dart
import 'package:flutter/material.dart';
import '../../models/machine.dart';
import '../../services/machine_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class MachineStatusScreen extends StatefulWidget {
  const MachineStatusScreen({super.key});

  @override
  State<MachineStatusScreen> createState() => _MachineStatusScreenState();
}

class _MachineStatusScreenState extends State<MachineStatusScreen> {
  late Future<List<Machine>> _machinesFuture;

  @override
  void initState() {
    super.initState();
    _machinesFuture = MachineService().getAllMachines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar code ...
      body: FutureBuilder<List<Machine>>(
        future: _machinesFuture,
        builder: (context, snapshot) {
          // ❌ Inconsistent loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // ❌ No error handling
          // ❌ Basic empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No machines found'));
          }

          return GridView.builder(
            // ... grid implementation ...
          );
        },
      ),
    );
  }
}
```

---

## After (With State Widgets)

```dart
import 'package:flutter/material.dart';
import '../../models/machine.dart';
import '../../services/machine_service.dart';
import '../../widgets/manufacturing_drawer.dart';
import '../../../common/widgets/states.dart'; // ✅ Add this import

class MachineStatusScreen extends StatefulWidget {
  const MachineStatusScreen({super.key});

  @override
  State<MachineStatusScreen> createState() => _MachineStatusScreenState();
}

class _MachineStatusScreenState extends State<MachineStatusScreen> {
  late Future<List<Machine>> _machinesFuture;

  @override
  void initState() {
    super.initState();
    _loadMachines();
  }

  void _loadMachines() {
    setState(() {
      _machinesFuture = MachineService().getAllMachines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar code ...
      body: FutureBuilder<List<Machine>>(
        future: _machinesFuture,
        builder: (context, snapshot) {
          // ✅ Consistent loading state with message
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(message: 'Loading machines...');
          }
          
          // ✅ Proper error handling with retry
          if (snapshot.hasError) {
            return ErrorState(
              message: 'Failed to load machines. Please check your connection.',
              onRetry: _loadMachines,
            );
          }
          
          // ✅ Professional empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyState(
              title: 'No Machines Registered',
              subtitle: 'Add machines to monitor their status and performance.',
              icon: Icons.precision_manufacturing_rounded,
            );
          }

          return GridView.builder(
            // ... grid implementation ...
          );
        },
      ),
    );
  }
}
```

---

## What Changed?

### 1. Added Import
```dart
import '../../../common/widgets/states.dart';
```

### 2. Loading State
**Before:**
```dart
return const Center(child: CircularProgressIndicator());
```

**After:**
```dart
return const LoadingState(message: 'Loading machines...');
```

### 3. Error Handling (NEW!)
```dart
if (snapshot.hasError) {
  return ErrorState(
    message: 'Failed to load machines. Please check your connection.',
    onRetry: _loadMachines,
  );
}
```

### 4. Empty State
**Before:**
```dart
return const Center(child: Text('No machines found'));
```

**After:**
```dart
return const EmptyState(
  title: 'No Machines Registered',
  subtitle: 'Add machines to monitor their status and performance.',
  icon: Icons.precision_manufacturing_rounded,
);
```

### 5. Added Refresh Method
```dart
void _loadMachines() {
  setState(() {
    _machinesFuture = MachineService().getAllMachines();
  });
}
```

---

## Benefits

✅ **Better UX** - Professional loading/error/empty states  
✅ **Error Recovery** - Users can retry failed requests  
✅ **Consistency** - Matches other screens in the app  
✅ **Maintainability** - Easier to update UI globally  
✅ **Less Code** - No custom UI for each state  

---

## Apply This Pattern To

- ✅ `bom_list_screen.dart`
- ✅ `work_order_list_screen.dart`
- ✅ `material_consumption_screen.dart`
- ✅ `finished_goods_tracking_screen.dart`
- ✅ `quality_control_screen.dart`

And all other screens with FutureBuilder/StreamBuilder!
