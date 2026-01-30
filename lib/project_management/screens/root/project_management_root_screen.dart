import 'package:flutter/material.dart';
import '../../widgets/project_drawer.dart';
import '../dashboard/project_dashboard_screen.dart';
import '../projects/projects_screen.dart';
import '../time_tracking/time_tracking_screen.dart';
import '../tasks/project_tasks_screen.dart';
import '../milestones/project_milestones_screen.dart';
import '../teams/project_teams_screen.dart';
import '../reports/project_reports_screen.dart';
import '../settings/project_settings_screen.dart';

class ProjectManagementRootScreen extends StatefulWidget {
  const ProjectManagementRootScreen({super.key});

  @override
  State<ProjectManagementRootScreen> createState() =>
      _ProjectManagementRootScreenState();
}

class _ProjectManagementRootScreenState
    extends State<ProjectManagementRootScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentScreen = 'Dashboard';

  void _onDrawerItemTapped(String screenName) {
    setState(() {
      _currentScreen = screenName;
    });
    Navigator.pop(context); // Close the drawer
  }

  void _navigateToDashboard() {
    setState(() {
      _currentScreen = 'Dashboard';
    });
  }

  Widget _getBody() {
    switch (_currentScreen) {
      case 'Dashboard':
        return const ProjectDashboardScreen();
      case 'Projects':
        return ProjectsScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Tasks':
        return ProjectTasksScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Milestones':
        return ProjectMilestonesScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Teams':
        return ProjectTeamsScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Time Tracking':
        return TimeTrackingScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Reports':
        return ProjectReportsScreen(
          onBack: _navigateToDashboard,
          onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        );
      case 'Settings':
        return ProjectSettingsScreen(
          onBack: _navigateToDashboard,
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
      appBar: null, // Custom header used in body
      endDrawer: ProjectDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      body: _getBody(),
    );
  }
}
