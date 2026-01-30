import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class RecruitmentScreen extends StatelessWidget {
  final VoidCallback onBack;

  const RecruitmentScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Recruitment',
            subtitle: 'Manage job openings & candidates',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildJobStats(),
                const SizedBox(height: 24),
                const Text(
                  'Active Job Openings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildJobCard(
                  'Senior Flutter Developer',
                  'Engineering',
                  '5 Applicants',
                  'Urgent',
                ),
                _buildJobCard(
                  'Tech Lead',
                  'Engineering',
                  '2 Applicants',
                  'New',
                ),
                _buildJobCard(
                  'Product Designer',
                  'Product',
                  '12 Applicants',
                  'Active',
                ),
                _buildJobCard(
                  'Marketing Manager',
                  'Marketing',
                  '8 Applicants',
                  'Active',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobStats() {
    return Row(
      children: [
        _buildStatItem('Openings', '12', Colors.blue),
        const SizedBox(width: 12),
        _buildStatItem('Candidates', '156', Colors.orange),
        const SizedBox(width: 12),
        _buildStatItem('Hired', '45', Colors.green),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    String title,
    String dept,
    String applicants,
    String badge,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEF2FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badge == 'Urgent'
                      ? Colors.red[50]
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badge == 'Urgent' ? Colors.red : Colors.grey[700],
                  ),
                ),
              ),
              const Icon(Icons.more_horiz_rounded, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(dept, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.people_alt_outlined,
                size: 16,
                color: Color(0xFF4776E6),
              ),
              const SizedBox(width: 8),
              Text(
                applicants,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4776E6),
                ),
              ),
              const Spacer(),
              const Text(
                'View Applications',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
