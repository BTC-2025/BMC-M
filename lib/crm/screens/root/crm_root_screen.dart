import 'package:flutter/material.dart';
import '../../widgets/crm_drawer.dart';
import '../dashboard/crm_dashboard.dart';
import '../leads/leads_screen.dart';
import '../customers/customers_screen.dart';
import '../deals/deal_pipeline_screen.dart';
import '../tasks/tasks_screen.dart';
import '../contacts/contacts_screen.dart';
import '../reports/crm_reports_screen.dart';
import '../settings/crm_settings_screen.dart';
import '../communication/crm_communication_screen.dart';
import '../campaigns/crm_campaigns_screen.dart';
import '../support/crm_support_screen.dart';
import '../products/crm_products_screen.dart';
import '../quotes/crm_quotes_screen.dart';
import '../users/crm_users_screen.dart';

class CrmRootScreen extends StatefulWidget {
  const CrmRootScreen({super.key});

  @override
  State<CrmRootScreen> createState() => _CrmRootScreenState();
}

class _CrmRootScreenState extends State<CrmRootScreen> {
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
        return const CrmDashboard();
      case 'Leads':
        return LeadsScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Customers':
        return CustomersScreen(
          onBack: _navigateToOverview,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Contacts':
        return ContactsScreen(onBack: _navigateToOverview);
      case 'Deal Pipeline':
        return DealPipelineScreen(onBack: _navigateToOverview);
      case 'Tasks':
        return TasksScreen(onBack: _navigateToOverview);
      case 'Communication':
        return CrmCommunicationScreen(onBack: _navigateToOverview);
      case 'Campaigns':
        return CrmCampaignsScreen(onBack: _navigateToOverview);
      case 'Support Tickets':
        return CrmSupportScreen(onBack: _navigateToOverview);
      case 'Products':
        return CrmProductsScreen(onBack: _navigateToOverview);
      case 'Quotes':
        return CrmQuotesScreen(onBack: _navigateToOverview);
      case 'Users':
        return CrmUsersScreen(onBack: _navigateToOverview);
      case 'Reports':
        return CrmReportsScreen(onBack: _navigateToOverview);
      case 'Settings':
        return CrmSettingsScreen(onBack: _navigateToOverview);
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null, // Custom header used in body
      endDrawer: CrmDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      body: _getBody(),
    );
  }
}
