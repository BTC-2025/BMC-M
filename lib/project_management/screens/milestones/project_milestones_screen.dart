import 'package:flutter/material.dart';

class ProjectMilestonesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectMilestonesScreen({super.key, this.onBack, this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: const Text(
          'Milestones',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (onMenu != null)
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
              onPressed: onMenu,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMilestoneCard('Project Kickoff', 'Jan 15, 2026', true),
          _buildMilestoneCard('Design Phase Complete', 'Feb 01, 2026', false),
          _buildMilestoneCard('Development Alpha', 'Mar 10, 2026', false),
          _buildMilestoneCard('Beta Release', 'Apr 05, 2026', false),
          _buildMilestoneCard('Go Live', 'May 01, 2026', false),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(String title, String date, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF05CD99).withValues(alpha: 0.1)
                  : const Color(0xFFF4F7FE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag_rounded,
              color: isCompleted
                  ? const Color(0xFF05CD99)
                  : const Color(0xFFA3AED0),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check_circle, color: Color(0xFF05CD99)),
        ],
      ),
    );
  }
}
