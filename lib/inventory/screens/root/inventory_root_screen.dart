import 'package:flutter/material.dart';
import '../../widgets/inventory_drawer.dart';
import '../dashboard/inventory_overview.dart';
import '../products/inventory_items_list.dart';
import '../categories/inventory_categories.dart';
import '../suppliers/inventory_suppliers.dart';
import '../warehouses/inventory_warehouses.dart';

// Stock Management
import '../stock_management/inventory_stock_levels_screen.dart';
import '../stock_management/inventory_stock_in_screen.dart';
import '../stock_management/inventory_stock_out_screen.dart';
import '../stock_management/inventory_stock_transfer_screen.dart';

// Reports
import '../reports/inventory_reports_screen.dart';
import '../reports/inventory_analytics_screen.dart';

// Alerts
import '../alerts/inventory_reorder_alerts_screen.dart';

// Orders
import '../orders/inventory_purchase_orders_screen.dart';
import '../orders/inventory_sales_orders_screen.dart';
import '../orders/inventory_returns_screen.dart';

// Tracking
import '../tracking/inventory_batch_tracking_screen.dart';
import '../tracking/inventory_serial_numbers_screen.dart';
import '../tracking/inventory_barcode_screen.dart';

// Settings
import '../settings/inventory_uom_screen.dart';
import '../settings/inventory_adjustments_screen.dart';
import '../settings/inventory_tax_currency_screen.dart';

// Add Screens
import '../products/inventory_add_product_screen.dart';
import '../categories/inventory_add_category_screen.dart';
import '../suppliers/inventory_add_supplier_screen.dart';

class InventoryRootScreen extends StatefulWidget {
  const InventoryRootScreen({super.key});

  @override
  State<InventoryRootScreen> createState() => _InventoryRootScreenState();
}

class _InventoryRootScreenState extends State<InventoryRootScreen> {
  String _currentScreen = 'Overview';

  void _onDrawerItemTapped(String screenName) {
    setState(() {
      _currentScreen = screenName;
    });
    Navigator.pop(context); // Close the drawer
  }

  void _navigateToOverview() {
    setState(() {
      _currentScreen = 'Overview';
    });
  }

  Widget _getBody() {
    switch (_currentScreen) {
      // Core Inventory
      case 'Overview':
        return const InventoryOverview();
      case 'Products':
        return InventoryItemsList(onBack: _navigateToOverview);
      case 'Categories':
        return InventoryCategories(onBack: _navigateToOverview);
      case 'Stock Levels':
        return InventoryStockLevelsScreen(onBack: _navigateToOverview);
      case 'Stock In':
        return InventoryStockInScreen(onBack: _navigateToOverview);
      case 'Stock Out':
        return InventoryStockOutScreen(onBack: _navigateToOverview);
      case 'Suppliers':
        return InventorySuppliers(onBack: _navigateToOverview);
      case 'Reports':
        return InventoryReportsScreen(onBack: _navigateToOverview);

      // Operations
      case 'Purchase Orders':
        return InventoryPurchaseOrdersScreen(onBack: _navigateToOverview);
      case 'Sales Orders':
        return InventorySalesOrdersScreen(onBack: _navigateToOverview);
      case 'Reorder Alerts':
        return InventoryReorderAlertsScreen(onBack: _navigateToOverview);
      case 'Returns':
        return InventoryReturnsScreen(onBack: _navigateToOverview);
      case 'Stock Transfer':
        return InventoryStockTransferScreen(onBack: _navigateToOverview);

      // Tracking & Locations
      case 'Warehouses':
        return const InventoryWarehouses();
      case 'Batch Tracking':
        return InventoryBatchTrackingScreen(onBack: _navigateToOverview);
      case 'Serial Numbers':
        return InventorySerialNumbersScreen(onBack: _navigateToOverview);
      case 'Barcode':
        return InventoryBarcodeScreen(onBack: _navigateToOverview);

      // Configuration
      case 'UOM':
        return InventoryUomScreen(onBack: _navigateToOverview);
      case 'Adjustments':
        return InventoryAdjustmentsScreen(onBack: _navigateToOverview);
      case 'Tax & Currency':
        return InventoryTaxCurrencyScreen(onBack: _navigateToOverview);
      case 'Analytics':
        return InventoryAnalyticsScreen(onBack: _navigateToOverview);

      default:
        return const Center(child: Text('Page not found'));
    }
  }

  Widget? _buildFloatingActionButton() {
    if (_currentScreen == 'Products') {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventoryAddProductScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF3B4CCA),
        child: const Icon(Icons.add, color: Colors.white),
      );
    } else if (_currentScreen == 'Categories') {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventoryAddCategoryScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF3B4CCA),
        child: const Icon(Icons.add, color: Colors.white),
      );
    } else if (_currentScreen == 'Suppliers') {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventoryAddSupplierScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF3B4CCA),
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      endDrawer: InventoryDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: _getBody(),
    );
  }
}
