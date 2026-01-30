import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class DepartmentsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const DepartmentsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Departments',
            subtitle: 'Manage organization units',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDepartmentCard(
                  'Engineering',
                  '42 Employees',
                  Icons.code_rounded,
                  Colors.blue,
                ),
                _buildDepartmentCard(
                  'Product Management',
                  '12 Employees',
                  Icons.lightbulb_rounded,
                  Colors.orange,
                ),
                _buildDepartmentCard(
                  'Sales & Marketing',
                  '28 Employees',
                  Icons.campaign_rounded,
                  Colors.green,
                ),
                _buildDepartmentCard(
                  'Human Resources',
                  '8 Employees',
                  Icons.people_rounded,
                  Colors.purple,
                ),
                _buildDepartmentCard(
                  'Finance',
                  '10 Employees',
                  Icons.account_balance_rounded,
                  Colors.teal,
                ),
                _buildDepartmentCard(
                  'Customer Support',
                  '15 Employees',
                  Icons.support_agent_rounded,
                  Colors.pink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(
    String name,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
