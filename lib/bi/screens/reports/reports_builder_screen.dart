import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../inventory/widgets/inventory_header.dart';

class ReportsBuilderScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ReportsBuilderScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

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
                title: 'Reports Builder',
                subtitle: 'Compose custom data exports',
                showBackButton: true,
                onBack: onBack,
                showMenuButton: true,
                onMenu: onMenu,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Source',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSourceCard('Sales', Iconsax.shop, true),
                          const SizedBox(width: 16),
                          _buildSourceCard('Inventory', Iconsax.box, false),
                          const SizedBox(width: 16),
                          _buildSourceCard(
                            'Finance',
                            Iconsax.wallet_money,
                            false,
                          ),
                          const SizedBox(width: 16),
                          _buildSourceCard('HRM', Iconsax.people, false),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'Report Composer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Drag fields here to build table columns',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFA3AED0).withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Report Canvas
                    Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE0E5F2)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFE0E5F2,
                            ).withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Mock Table Header
                          Row(
                            children: [
                              _buildColumnHeader('Product Name'),
                              const SizedBox(width: 8),
                              _buildColumnHeader('Category'),
                              const SizedBox(width: 8),
                              _buildColumnHeader('Revenue'),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F7FE),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(
                                        0xFFA3AED0,
                                      ).withValues(alpha: 0.3),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFFA3AED0),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Mock Empty State
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.document_text,
                                    size: 40,
                                    color: const Color(
                                      0xFFA3AED0,
                                    ).withValues(alpha: 0.3),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Preview Area',
                                    style: TextStyle(
                                      color: const Color(
                                        0xFFA3AED0,
                                      ).withValues(alpha: 0.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'Available Fields',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2559),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Draggable Fields
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildDraggableField('Date', Iconsax.calendar_1),
                        _buildDraggableField('Product Name', Iconsax.box),
                        _buildDraggableField('SKU', Iconsax.barcode),
                        _buildDraggableField('Category', Iconsax.category),
                        _buildDraggableField('Revenue', Iconsax.money_3),
                        _buildDraggableField('Cost', Iconsax.money_2),
                        _buildDraggableField(
                          'Units Sold',
                          Iconsax.shopping_cart,
                        ),
                        _buildDraggableField('Region', Iconsax.map),
                        _buildDraggableField('Store ID', Iconsax.shop),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF2E3192),
        elevation: 10,
        icon: const Icon(Icons.download_rounded, color: Colors.white),
        label: const Text(
          'Export Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSourceCard(String title, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4318FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? const Color(0xFF4318FF).withValues(alpha: 0.4)
                : const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : const Color(0xFFA3AED0),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1B2559),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnHeader(String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7FE),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E5F2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1B2559),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.close, size: 12, color: Color(0xFFA3AED0)),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableField(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE0E5F2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF05CD99), size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1B2559),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
