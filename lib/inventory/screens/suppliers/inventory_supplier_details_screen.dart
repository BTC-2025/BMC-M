import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventorySupplierDetailsScreen extends StatelessWidget {
  const InventorySupplierDetailsScreen({super.key});

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
                title: 'Supplier Details',
                subtitle: 'View partner information',
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
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.local_shipping_rounded,
                                color: Color(0xFF1976D2),
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Global Logistics',
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
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFFB300),
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.8 Verified',
                                    style: TextStyle(
                                      color: Color(0xFFFF8F00),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Details Grid
                      _buildSectionTitle('Contact Information'),
                      const SizedBox(height: 20),
                      _buildInfoRow('Contact Person', 'John Doe'),
                      const Divider(height: 32, color: Color(0xFFF4F7FE)),
                      _buildInfoRow('Email', 'support@globallogistics.com'),
                      const Divider(height: 32, color: Color(0xFFF4F7FE)),
                      _buildInfoRow('Phone', '+1 (555) 123-4567'),

                      const SizedBox(height: 40),

                      // Edit Button (Placeholder action)
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Edit Screen (to be created if needed, or placeholder)
                            // For now, just print
                            debugPrint("Navigate to Edit Supplier");
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
                                'Edit Supplier',
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
