import 'package:flutter/material.dart';
import '../../widgets/finance_drawer.dart';
import '../dashboard/finance_dashboard.dart';
import '../dashboard/finance_dossiers_screen.dart';
import '../accounts/chart_of_accounts_screen.dart';
import '../liquidity/liquidity_screen.dart';
import '../billing/billing_invoices_screen.dart';
import '../accounts/receivable_screen.dart';
import '../accounts/payables_screen.dart';
import '../accounts/operational_costs_screen.dart';
import '../ledger/settlement_ledger_screen.dart';
import '../tax/tax_compliance_screen.dart';
import '../assets/asset_overview_screen.dart';
import '../assets/asset_registry_screen.dart';
import '../assets/depreciation_log_screen.dart';

class FinanceRootScreen extends StatefulWidget {
  const FinanceRootScreen({super.key});

  @override
  State<FinanceRootScreen> createState() => _FinanceRootScreenState();
}

class _FinanceRootScreenState extends State<FinanceRootScreen> {
  String _selectedSection = 'Dashboard';

  void _onItemTapped(String section) {
    setState(() {
      _selectedSection = section;
    });
    Navigator.pop(context); // Close drawer
  }

  void _navigateToOverview() {
    setState(() {
      _selectedSection = 'Dashboard';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FinanceDrawer(
        onItemTapped: _onItemTapped,
        selectedItem: _selectedSection,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: _buildSelectedScreen(),
    );
  }

  Widget? _buildFloatingActionButton() {
    switch (_selectedSection) {
      case 'Finance Dossiers':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          child: const Icon(
            Icons.create_new_folder_rounded,
            color: Colors.white,
          ),
        );
      case 'Chart of Accounts':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          child: const Icon(Icons.add_rounded, color: Colors.white),
        );
      case 'Billing & Invoices':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'New Invoice',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Payables':
        return FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          icon: const Icon(Icons.payment_rounded, color: Colors.white),
          label: const Text(
            'New Payment',
            style: TextStyle(color: Colors.white),
          ),
        );
      case 'Asset Registry':
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          child: const Icon(Icons.add_a_photo_rounded, color: Colors.white),
        );
      default:
        return null;
    }
  }

  Widget _buildSelectedScreen() {
    switch (_selectedSection) {
      case 'Dashboard':
        return const FinanceDashboard();
      case 'Finance Dossiers':
        return FinanceDossiersScreen(onBack: _navigateToOverview);
      case 'Chart of Accounts':
        return ChartOfAccountsScreen(onBack: _navigateToOverview);
      case 'Liquidity':
        return LiquidityScreen(onBack: _navigateToOverview);
      case 'Billing & Invoices':
        return BillingInvoicesScreen(onBack: _navigateToOverview);
      case 'Receivable':
        return ReceivableScreen(onBack: _navigateToOverview);
      case 'Payables':
        return PayablesScreen(onBack: _navigateToOverview);
      case 'Operational Costs':
        return OperationalCostsScreen(onBack: _navigateToOverview);
      case 'Settlement Ledger':
        return SettlementLedgerScreen(onBack: _navigateToOverview);
      case 'Tax Compliance':
        return TaxComplianceScreen(onBack: _navigateToOverview);
      case 'Asset Overview':
        return AssetOverviewScreen(onBack: _navigateToOverview);
      case 'Asset Registry':
        return AssetRegistryScreen(onBack: _navigateToOverview);
      case 'Depreciation Log':
        return DepreciationLogScreen(onBack: _navigateToOverview);
      default:
        return const FinanceDashboard();
    }
  }
}
