import 'package:flutter/material.dart';
import '../../../navigation/route_names.dart';

class BusinessTypeSelectionScreen extends StatefulWidget {
  const BusinessTypeSelectionScreen({super.key});

  @override
  State<BusinessTypeSelectionScreen> createState() =>
      _BusinessTypeSelectionScreenState();
}

class _BusinessTypeSelectionScreenState
    extends State<BusinessTypeSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectBusinessType(String type) {
    setState(() {
      _selectedType = type;
    });

    // Wait a moment to show selection, then navigate
    Future.delayed(const Duration(milliseconds: 400), () {
      // TODO: Save selected business type to user preferences/database
      Navigator.pushReplacementNamed(context, RouteNames.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Header
                _buildHeader(),

                const Spacer(),

                // Business Type Options
                _buildBusinessTypeOption(
                  type: 'small',
                  title: 'Small Scale Business',
                  subtitle: 'Startups, small teams, local shops',
                  icon: Icons.store_mall_directory_rounded,
                  color: const Color(0xFF05CD99),
                ),

                const SizedBox(height: 20),

                _buildBusinessTypeOption(
                  type: 'large',
                  title: 'Large Scale Business',
                  subtitle: 'Enterprises, corporations, multi-location',
                  icon: Icons.apartment_rounded,
                  color: const Color(0xFF4318FF),
                ),

                const Spacer(),

                // Skip Button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.dashboard,
                    );
                  },
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Color(0xFFA3AED0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4318FF), Color(0xFF5B30BA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4318FF).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.business_center_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'What type of business\nare you running?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'This helps us customize your experience',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color(0xFFA3AED0)),
        ),
      ],
    );
  }

  Widget _buildBusinessTypeOption({
    required String type,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedType == type;

    return GestureDetector(
      onTap: () => _selectBusinessType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withValues(alpha: 0.3)
                  : const Color(0xFFE0E5F2).withValues(alpha: 0.5),
              blurRadius: isSelected ? 20 : 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA3AED0),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Selection Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : const Color(0xFFE0E5F2),
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
