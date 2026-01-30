import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class CompanyPolicyScreen extends StatelessWidget {
  final VoidCallback onBack;

  const CompanyPolicyScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: Column(
        children: [
          HrmHeader(
            title: 'Company Policy',
            subtitle: 'Rules, regulations and employee handbook',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHandbookCard(),
                const SizedBox(height: 24),
                const Text(
                  'Policy Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _buildPolicyCategoryCard(
                      'Code of Conduct',
                      '12 Documents',
                      Icons.gavel_rounded,
                      const Color(0xFF4318FF),
                    ),
                    _buildPolicyCategoryCard(
                      'Leave & Attendance',
                      '8 Documents',
                      Icons.calendar_month_rounded,
                      const Color(0xFFFFB547),
                    ),
                    _buildPolicyCategoryCard(
                      'Health & Safety',
                      '5 Documents',
                      Icons.health_and_safety_rounded,
                      const Color(0xFF05CD99),
                    ),
                    _buildPolicyCategoryCard(
                      'IT & Data Security',
                      '10 Documents',
                      Icons.security_rounded,
                      const Color(0xFF2B3674),
                    ),
                    _buildPolicyCategoryCard(
                      'Benefits & Perks',
                      '6 Documents',
                      Icons.card_giftcard_rounded,
                      const Color(0xFFEE5D50),
                    ),
                    _buildPolicyCategoryCard(
                      'Onboarding',
                      '4 Documents',
                      Icons.person_add_rounded,
                      const Color(0xFF1E88E5),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandbookCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4318FF).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.menu_book_rounded, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF05CD99),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'New Version',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Employee Handbook',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Revision 2024.1 • Updated Dec 01, 2023',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4318FF),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Read Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCategoryCard(
    String title,
    String docs,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                docs,
                style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
