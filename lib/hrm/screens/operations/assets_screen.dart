import 'package:flutter/material.dart';
import '../../widgets/hrm_header.dart';

class AssetsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AssetsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          HrmHeader(
            title: 'Assets',
            subtitle: 'Company assets assigned to staff',
            onBack: onBack,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAssetCard(
                  'MacBook Pro M2',
                  'Laptop',
                  'Alex Johnson',
                  'Assigned',
                  Colors.blue,
                ),
                _buildAssetCard(
                  'Dell 27" Monitor',
                  'Peripheral',
                  'Sarah Conon',
                  'Assigned',
                  Colors.blue,
                ),
                _buildAssetCard(
                  'iPhone 15 Pro',
                  'Mobile',
                  '-',
                  'Available',
                  Colors.green,
                ),
                _buildAssetCard(
                  'Logitech MX Master',
                  'Peripheral',
                  'Mike Ross',
                  'Assigned',
                  Colors.blue,
                ),
                _buildAssetCard(
                  'Standing Desk',
                  'Furniture',
                  '-',
                  'Maintenance',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetCard(
    String name,
    String type,
    String assignedTo,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEF2FF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              type == 'Laptop'
                  ? Icons.laptop_mac_rounded
                  : Icons.devices_other_rounded,
              color: color,
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
                  'Type: $type',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Assigned To: $assignedTo',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Available'
                  ? Colors.green[50]
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Available' ? Colors.green : Colors.grey[700],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
