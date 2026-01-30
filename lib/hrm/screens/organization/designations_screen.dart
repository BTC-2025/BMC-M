import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class DesignationsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const DesignationsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Designations',
            subtitle: 'Define organizational roles',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDesignationCard(
                  'Senior Software Engineer',
                  'Level 4',
                  '15 Staff',
                ),
                _buildDesignationCard('Product Manager', 'Level 3', '8 Staff'),
                _buildDesignationCard('UI/UX Designer', 'Level 3', '6 Staff'),
                _buildDesignationCard(
                  'Marketing Specialist',
                  'Level 2',
                  '10 Staff',
                ),
                _buildDesignationCard(
                  'Frontend Developer',
                  'Level 2',
                  '12 Staff',
                ),
                _buildDesignationCard('HR Manager', 'Level 4', '2 Staff'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignationCard(String title, String level, String staffCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        level,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF4776E6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      staffCount,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
    );
  }
}
