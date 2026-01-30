import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';
import 'inventory_supplier_details_screen.dart';

class InventorySuppliers extends StatelessWidget {
  final VoidCallback? onBack;

  const InventorySuppliers({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: InventoryHeader(
                title: 'Suppliers',
                subtitle: 'Manage Logistics Partners',
                onBack: onBack,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: 8,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildSupplierTile(context, index);
                },
              ),
            ),
            // Bottom space for FAB
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InventorySupplierDetailsScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? const Color(0xFFE3F2FD)
                    : const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.local_shipping_rounded,
                color: index % 2 == 0
                    ? const Color(0xFF2196F3)
                    : const Color(0xFF9C27B0),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Global Logistics #${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1B2559),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFFFB547),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '4.8 Rating • Verified Partner',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFA3AED0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // REPLACED CALL ICON WITH MENU ICON (3 DOTS)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent for clean look
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.more_vert_rounded,
                color: Color(0xFFA3AED0),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
