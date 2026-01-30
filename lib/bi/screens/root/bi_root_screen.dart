import 'package:flutter/material.dart';
import '../../widgets/bi_drawer.dart';
import '../overview/executive_overview_screen.dart';
import '../analytics/module_analytics_screen.dart';
import '../analytics/cross_module_intelligence_screen.dart';
import '../dashboards/custom_dashboards_screen.dart';
import '../dashboards/kpi_builder_screen.dart';
import '../reports/reports_builder_screen.dart';
import '../reports/scheduled_reports_screen.dart';
import '../settings/alerts_insights_screen.dart';
import '../settings/data_model_screen.dart';

class BiRootScreen extends StatefulWidget {
  const BiRootScreen({super.key});

  @override
  State<BiRootScreen> createState() => _BiRootScreenState();
}

class _BiRootScreenState extends State<BiRootScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentScreen = 'Executive Overview';

  void _onDrawerItemTapped(String screenName) {
    setState(() {
      _currentScreen = screenName;
    });
    Navigator.pop(context); // Close the drawer
  }

  void _navigateToOverview() {
    setState(() {
      _currentScreen = 'Executive Overview';
    });
  }

  Widget _getBody() {
    switch (_currentScreen) {
      case 'Executive Overview':
        return ExecutiveOverviewScreen(
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Module Analytics':
        return ModuleAnalyticsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Cross-Module Intelligence':
        return CrossModuleIntelligenceScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Custom Dashboards':
        return CustomDashboardsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'KPI Builder':
        return KpiBuilderScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Reports Builder':
        return ReportsBuilderScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Scheduled Reports':
        return ScheduledReportsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Alerts & Insights':
        return AlertsInsightsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Data Model':
        return DataModelScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      default:
        return Center(child: Text('Screen $_currentScreen not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      endDrawer: BiDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      body: _getBody(),
    );
  }
}
