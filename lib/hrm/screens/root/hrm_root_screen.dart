import 'package:flutter/material.dart';
import '../../widgets/hrm_drawer.dart';
import '../dashboard/hr_dashboard.dart';
import '../employees/employees_screen.dart';
import '../organization/departments_screen.dart';
import '../organization/designations_screen.dart';
import '../attendance/attendance_screen.dart';
import '../attendance/leave_requests_screen.dart';
import '../attendance/shift_management_screen.dart';
import '../payroll/payroll_screen.dart';
import '../payroll/payslips_screen.dart';
import '../payroll/bonus_deductions_screen.dart';
import '../recruitment/recruitment_screen.dart';
import '../performance/performance_screen.dart';
import '../performance/training_screen.dart';
import '../settings/company_policy_screen.dart';
import '../reports/hrm_reports_screen.dart';
import '../settings/hrm_settings_screen.dart';
import '../operations/assets_screen.dart';
import '../operations/expenses_screen.dart';
import '../operations/holidays_screen.dart';
import '../exit/resignation_screen.dart';

class HrmRootScreen extends StatefulWidget {
  const HrmRootScreen({super.key});

  @override
  State<HrmRootScreen> createState() => _HrmRootScreenState();
}

class _HrmRootScreenState extends State<HrmRootScreen> {
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
      // Core HRM / PEOPLE
      case 'Overview':
        return const HrDashboard();
      case 'Employees':
        return EmployeesScreen(onBack: _navigateToOverview);
      case 'Departments':
        return DepartmentsScreen(onBack: _navigateToOverview);
      case 'Designations':
        return DesignationsScreen(onBack: _navigateToOverview);

      // TIME & LEAVE
      case 'Attendance':
        return AttendanceScreen(onBack: _navigateToOverview);
      case 'Leave Requests':
        return LeaveRequestsScreen(onBack: _navigateToOverview);
      case 'Shift Management':
        return ShiftManagementScreen(onBack: _navigateToOverview);

      // FINANCE
      case 'Payroll':
        return PayrollScreen(onBack: _navigateToOverview);
      case 'Payslips':
        return PayslipsScreen(onBack: _navigateToOverview);
      case 'Bonus & Deductions':
        return BonusDeductionsScreen(onBack: _navigateToOverview);

      // TALENT & GROWTH
      case 'Recruitment':
        return RecruitmentScreen(onBack: _navigateToOverview);
      case 'Performance':
        return PerformanceScreen(onBack: _navigateToOverview);
      case 'Training':
        return TrainingScreen(onBack: _navigateToOverview);

      // OPERATIONS
      case 'Assets':
        return AssetsScreen(onBack: _navigateToOverview);
      case 'Expenses':
        return ExpensesScreen(onBack: _navigateToOverview);
      case 'Holidays':
        return HolidaysScreen(onBack: _navigateToOverview);

      // EXIT
      case 'Resignation':
        return ResignationScreen(onBack: _navigateToOverview);

      // ADMIN
      case 'Company Policy':
        return CompanyPolicyScreen(onBack: _navigateToOverview);
      case 'Reports':
        return HrmReportsScreen(onBack: _navigateToOverview);
      case 'Settings':
        return HrmSettingsScreen(onBack: _navigateToOverview);

      default:
        return const Center(child: Text('Page not found'));
    }
  }

  Widget? _buildFloatingActionButton() {
    switch (_currentScreen) {
      case 'Employees':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.person_add_rounded, color: Colors.white),
        );
      case 'Departments':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.add_business_rounded, color: Colors.white),
        );
      case 'Designations':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.add_rounded, color: Colors.white),
        );
      case 'Attendance':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
          label: const Text(
            'Mark Attendance',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Leave Requests':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.add_box_rounded, color: Colors.white),
          label: const Text(
            'New Request',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Shift Management':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.add_alarm_rounded, color: Colors.white),
        );
      case 'Payroll':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
          label: const Text(
            'Run Payroll',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Bonus & Deductions':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'Add Adjustment',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Recruitment':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.add_box_rounded, color: Colors.white),
          label: const Text(
            'Post New Job',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Performance':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.star_rate_rounded, color: Colors.white),
          label: const Text(
            'Start Review',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Training':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.school_rounded, color: Colors.white),
          label: const Text(
            'Create Program',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Assets':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.add_rounded, color: Colors.white),
        );
      case 'Expenses':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text('New Claim', style: TextStyle(color: Colors.white)),
        );
      case 'Holidays':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF4776E6),
          child: const Icon(Icons.edit_calendar_rounded, color: Colors.white),
        );
      case 'Resignation':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
          label: const Text(
            'New Resignation',
            style: TextStyle(color: Colors.white),
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      endDrawer: HrmDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: _currentScreen,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: _getBody(),
    );
  }
}
