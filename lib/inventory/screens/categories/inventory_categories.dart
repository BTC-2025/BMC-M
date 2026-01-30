import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';
import 'inventory_category_details_screen.dart'; // IMPORT DETAILS SCREEN

class InventoryCategories extends StatelessWidget {
  final VoidCallback? onBack;

  const InventoryCategories({super.key, this.onBack});

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
                title: 'Categories',
                subtitle: 'Organize your stock',
                onBack: onBack,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _buildMinimalCategoryCard(context, index);
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalCategoryCard(BuildContext context, int index) {
    final List<Map<String, dynamic>> categories = [
      {
        'icon': Icons.computer_outlined,
        'name': 'Electronics',
        'color': Colors.blue,
      },
      {
        'icon': Icons.chair_outlined,
        'name': 'Furniture',
        'color': Colors.brown,
      },
      {'icon': Icons.print_outlined, 'name': 'Office', 'color': Colors.orange},
      {'icon': Icons.build_outlined, 'name': 'Tools', 'color': Colors.grey},
      {
        'icon': Icons.local_shipping_outlined,
        'name': 'Shipping',
        'color': Colors.teal,
      },
      {'icon': Icons.security_outlined, 'name': 'Safety', 'color': Colors.red},
      {
        'icon': Icons.medical_services_outlined,
        'name': 'Medical',
        'color': Colors.pink,
      },
      {
        'icon': Icons.more_horiz_outlined,
        'name': 'Others',
        'color': Colors.indigo,
      },
    ];

    final category = categories[index % categories.length];
    final color = category['color'] as Color;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const InventoryCategoryDetailsScreen(), // NAVIGATE TO DETAILS
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: color,
                      size: 24,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[300],
                    size: 14,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1B2559),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(index + 1) * 12} items',
                    style: const TextStyle(
                      color: Color(0xFFA3AED0),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
