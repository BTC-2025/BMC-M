import 'package:flutter/material.dart';
import 'route_names.dart';
import '../dashboard/dashboard_screen.dart';
import '../inventory/screens/root/inventory_root_screen.dart';
import '../crm/screens/root/crm_root_screen.dart';
import '../hrm/screens/root/hrm_root_screen.dart';
import '../finance/screens/root/finance_root_screen.dart';
import '../project_management/screens/root/project_management_root_screen.dart';
import '../manufacturing/screens/root/manufacturing_root_screen.dart';
import '../scm/screens/root/scm_root_screen.dart';
import '../common/screens/premium/upgrade_to_pro_screen.dart';
import '../dashboard/settings_screen.dart';
import '../dashboard/reports_screen.dart';
import '../bi/screens/root/bi_root_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteNames.analytics:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: ReportsScreen()),
        );
      case RouteNames.inventory:
        return MaterialPageRoute(builder: (_) => const InventoryRootScreen());
      case RouteNames.crm:
        return MaterialPageRoute(builder: (_) => const CrmRootScreen());
      case RouteNames.hrm:
        return MaterialPageRoute(builder: (_) => const HrmRootScreen());
      case RouteNames.finance:
        return MaterialPageRoute(builder: (_) => const FinanceRootScreen());
      case RouteNames.projectManagement:
        return MaterialPageRoute(
          builder: (_) => const ProjectManagementRootScreen(),
        );
      case RouteNames.manufacturing:
        return MaterialPageRoute(
          builder: (_) => const ManufacturingRootScreen(),
        );
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteNames.scm:
        return MaterialPageRoute(builder: (_) => const ScmRootScreen());
      case RouteNames.upgradeToPro:
        return MaterialPageRoute(builder: (_) => const UpgradeToProScreen());
      case RouteNames.bi:
        return MaterialPageRoute(builder: (_) => const BiRootScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
