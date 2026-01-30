import 'package:flutter/material.dart';
import '../../widgets/manufacturing_drawer.dart';
import '../dashboard/manufacturing_dashboard_screen.dart';
import '../bom/bom_list_screen.dart';
import '../work_orders/work_order_list_screen.dart';
import '../planning/production_planning_screen.dart';
import '../consumption/material_consumption_screen.dart';
import '../finished_goods/finished_goods_tracking_screen.dart';
import '../costing/production_costing_screen.dart';
import '../reports/manufacturing_reports_screen.dart';
import '../machines/machine_status_screen.dart';
import '../quality/quality_control_screen.dart';
import '../maintenance/maintenance_screen.dart';
import '../maintenance/downtime_log_screen.dart';
import '../compliance/compliance_screen.dart';
import '../efficiency/efficiency_stats_screen.dart';

class ManufacturingRootScreen extends StatefulWidget {
  const ManufacturingRootScreen({super.key});

  @override
  State<ManufacturingRootScreen> createState() =>
      _ManufacturingRootScreenState();
}

class _ManufacturingRootScreenState extends State<ManufacturingRootScreen> {
  String _currentScreen = 'Overview';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onDrawerItemTapped(String screenName) {
    setState(() {
      _currentScreen = screenName;
    });
    Navigator.pop(context); // Close the drawer
  }

  Widget _getBody() {
    switch (_currentScreen) {
      case 'Overview':
        return const ManufacturingDashboardScreen();
      case 'Bill of Materials':
        return const BomListScreen();
      case 'Work Orders':
        return const WorkOrderListScreen();
      case 'Production Planning':
        return const ProductionPlanningScreen();
      case 'Material Consumption':
        return const MaterialConsumptionScreen();
      case 'Finished Goods':
        return const FinishedGoodsTrackingScreen();
      case 'Production Costing':
        return const ProductionCostingScreen();
      case 'Production Reports':
        return const ManufacturingReportsScreen();
      case 'Machine Status':
        return const MachineStatusScreen();
      case 'Maintenance':
        return const MaintenanceScreen();
      case 'Downtime Log':
        return const DowntimeLogScreen();
      case 'QC Inspections':
        return const QualityControlScreen();
      case 'Compliance':
        return const ComplianceScreen();
      case 'Efficiency Stats':
        return const EfficiencyStatsScreen();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      endDrawer: ManufacturingDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      body: _getBody(),
    );
  }
}
