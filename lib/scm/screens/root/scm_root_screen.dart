import 'package:flutter/material.dart';
import '../../widgets/scm_drawer.dart';
import '../dashboard/scm_dashboard_screen.dart';
import '../suppliers/suppliers_screen.dart';
import '../procurement/purchase_orders_screen.dart';
import '../logistics/shipments_screen.dart';
import '../inventory/warehouses_screen.dart';
import '../reports/scm_reports_screen.dart';
import '../logistics/shipment_tracking_screen.dart';
import '../procurement/requisitions_screen.dart';

class ScmRootScreen extends StatefulWidget {
  const ScmRootScreen({super.key});

  @override
  State<ScmRootScreen> createState() => _ScmRootScreenState();
}

class _ScmRootScreenState extends State<ScmRootScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      case 'Overview':
        return const ScmDashboardScreen();
      case 'Suppliers':
        return SuppliersScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      // Placeholder for other screens for now
      case 'Purchase Orders':
        return PurchaseOrdersScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Requisitions':
        return RequisitionsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Shipments':
        return ShipmentsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Tracking':
        return ShipmentTrackingScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Warehouses':
        return WarehousesScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Reports':
        return ScmReportsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null, // Custom app bar in screens
      endDrawer: ScmDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      body: _getBody(),
    );
  }
}
