import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class PerformanceScreen extends StatelessWidget {
  final VoidCallback onBack;

  const PerformanceScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Performance',
            subtitle: 'Track appraisals and employee growth',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildPerformanceOverview(),
                const SizedBox(height: 24),
                _buildAppraisalSection(),
                const SizedBox(height: 24),
                const Text(
                  'Top Performers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPerformerCard(
                  'John Doe',
                  'Engineering',
                  '4.9/5.0',
                  Colors.blue,
                ),
                _buildPerformerCard(
                  'Sarah Conon',
                  'Marketing',
                  '4.8/5.0',
                  Colors.green,
                ),
                _buildPerformerCard(
                  'Mike Ross',
                  'Legal',
                  '4.7/5.0',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Organization Average',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                '4.2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.star_rounded, color: Colors.amber, size: 28),
              Spacer(),
              Text(
                '+0.3 from last year',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.84,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildAppraisalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEF2FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Appraisal Cycle',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.info_outline_rounded, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          _buildAppraisalStep('Goal Setting', 'Completed', true),
          _buildAppraisalStep('Self Assessment', 'In Progress', false),
          _buildAppraisalStep('Manager Review', 'Upcoming', false),
        ],
      ),
    );
  }

  Widget _buildAppraisalStep(String title, String status, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: isDone ? Colors.green : Colors.grey[400],
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              color: isDone ? const Color(0xFF1E293B) : Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(status, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildPerformerCard(
    String name,
    String dept,
    String score,
    Color color,
  ) {
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
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dept,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text(
                  score,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
