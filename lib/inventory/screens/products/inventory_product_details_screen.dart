import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';
import 'inventory_edit_product_screen.dart';

class InventoryProductDetailsScreen extends StatelessWidget {
  const InventoryProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: InventoryHeader(
                title: 'Product Details',
                subtitle: 'View inventory information',
                showMenuButton: false,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF90A4AE).withValues(alpha: 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section with Icon
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F7FE),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFF4A55A2),
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'iPhone 15 Pro Max',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B2559),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'In Stock',
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Details Grid
                      _buildSectionTitle('General Information'),
                      const SizedBox(height: 20),
                      _buildInfoRow('SKU', 'PROD-001'),
                      const Divider(height: 32, color: Color(0xFFF4F7FE)),
                      _buildInfoRow('Category', 'Electronics'),
                      const Divider(height: 32, color: Color(0xFFF4F7FE)),

                      const SizedBox(height: 10),
                      _buildSectionTitle('Pricing & Stock'),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow('Cost Price', '\$800.00'),
                          ),
                          Expanded(
                            child: _buildInfoRow('Sale Price', '\$999.00'),
                          ),
                        ],
                      ),
                      const Divider(height: 32, color: Color(0xFFF4F7FE)),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow('Current Stock', '150'),
                          ),
                          Expanded(child: _buildInfoRow('Reorder Point', '20')),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Edit Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const InventoryEditProductScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B4CCA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            shadowColor: const Color(
                              0xFF3B4CCA,
                            ).withValues(alpha: 0.5),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_outlined, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Edit Item',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFA3AED0),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
          ),
        ),
      ],
    );
  }
}
