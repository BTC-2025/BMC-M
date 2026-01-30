import 'package:flutter/material.dart';
import '../../widgets/finance_header.dart';

class FinanceDossiersScreen extends StatelessWidget {
  final VoidCallback onBack;

  const FinanceDossiersScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          FinanceHeader(
            title: 'Finance Dossiers',
            subtitle: 'Secure financial documents & folders',
            onBack: onBack,
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDossierFolder(
                  'Audit 2023',
                  '12 Files',
                  Icons.folder_zip_rounded,
                  Colors.orange,
                ),
                _buildDossierFolder(
                  'Tax Returns',
                  '8 Files',
                  Icons.folder_shared_rounded,
                  Colors.blue,
                ),
                _buildDossierFolder(
                  'Bank Stmts',
                  '24 Files',
                  Icons.folder_rounded,
                  Colors.green,
                ),
                _buildDossierFolder(
                  'Invoices Q4',
                  '150 Files',
                  Icons.folder_copy_rounded,
                  Colors.purple,
                ),
                _buildDossierFolder(
                  'Legal Docs',
                  '5 Files',
                  Icons.folder_special_rounded,
                  Colors.red,
                ),
                _buildDossierFolder(
                  'Payroll Arch',
                  '36 Files',
                  Icons.folder_rounded,
                  Colors.indigo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDossierFolder(
    String name,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(count, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}
