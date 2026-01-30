import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class CreateDashboardScreen extends StatefulWidget {
  final VoidCallback onBack;

  const CreateDashboardScreen({super.key, required this.onBack});

  @override
  State<CreateDashboardScreen> createState() => _CreateDashboardScreenState();
}

class _CreateDashboardScreenState extends State<CreateDashboardScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: InventoryHeader(
                title: 'New Dashboard',
                subtitle: 'Step ${_currentStep + 1} of 3',
                showBackButton: true,
                onBack: widget.onBack,
                showMenuButton: false,
              ),
            ),

            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildProgressStep(0, 'Template'),
                  _buildConnector(0),
                  _buildProgressStep(1, 'Layout'),
                  _buildConnector(1),
                  _buildProgressStep(2, 'Widgets'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildCurrentStepContent(),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _currentStep == 0
                        ? null
                        : () {
                            setState(() => _currentStep--);
                          },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: _currentStep == 0
                            ? Colors.grey
                            : const Color(0xFFA3AED0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 2) {
                        setState(() => _currentStep++);
                      } else {
                        // Finish
                        widget.onBack();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4318FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'Create Dashboard' : 'Next Step',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(int stepIndex, String label) {
    bool isActive = _currentStep >= stepIndex;
    bool isCurrent = _currentStep == stepIndex;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF4318FF) : const Color(0xFFE0E5F2),
            shape: BoxShape.circle,
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: const Color(0xFF4318FF).withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: isActive
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${stepIndex + 1}',
                    style: const TextStyle(
                      color: Color(0xFFA3AED0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF1B2559) : const Color(0xFFA3AED0),
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(int index) {
    bool isActive = _currentStep > index;
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFF4318FF) : const Color(0xFFE0E5F2),
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Template',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start with a pre-built structure',
              style: TextStyle(color: Color(0xFFA3AED0)),
            ),
            const SizedBox(height: 24),
            _buildTemplateCard('Executive Summary', Iconsax.chart_2, true),
            const SizedBox(height: 16),
            _buildTemplateCard('Operational View', Iconsax.activity, false),
            const SizedBox(height: 16),
            _buildTemplateCard('Blank Canvas', Iconsax.add_circle, false),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Layout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 24),
            _buildLayoutOption('Grid View', Iconsax.grid_1, true),
            const SizedBox(height: 16),
            _buildLayoutOption(
              'List View',
              Iconsax.textalign_justifycenter,
              false,
            ),
            const SizedBox(height: 16),
            _buildLayoutOption('Freeform', Iconsax.autobrightness, false),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Widgets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildWidgetOption('KPI Card', Iconsax.card, Colors.blue),
                _buildWidgetOption(
                  'Revenue Chart',
                  Iconsax.graph,
                  Colors.purple,
                ),
                _buildWidgetOption('User Table', Iconsax.user, Colors.orange),
                _buildWidgetOption(
                  'Activity Feed',
                  Iconsax.activity,
                  Colors.green,
                ),
                _buildWidgetOption('Map View', Iconsax.map, Colors.red),
              ],
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTemplateCard(String title, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: const Color(0xFF4318FF), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4318FF).withValues(alpha: 0.1)
                  : const Color(0xFFF4F7FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF4318FF)
                  : const Color(0xFFA3AED0),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFF4318FF)
                  : const Color(0xFF1B2559),
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(Icons.check_circle, color: Color(0xFF4318FF)),
        ],
      ),
    );
  }

  Widget _buildLayoutOption(String title, IconData icon, bool isSelected) {
    // Reusing template card style for layout options for consistency
    return _buildTemplateCard(title, icon, isSelected);
  }

  Widget _buildWidgetOption(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
