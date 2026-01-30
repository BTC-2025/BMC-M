import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryAddCategoryScreen extends StatelessWidget {
  const InventoryAddCategoryScreen({super.key});

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
                title: 'Add Category',
                subtitle: 'Create new product category',
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
                      _buildSectionTitle('Category Details'),
                      const SizedBox(height: 24),
                      _buildLabel('Category Name'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(hint: 'e.g., Electronics'),
                      const SizedBox(height: 24),
                      _buildLabel('Description'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(
                        hint: 'Optional description...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      _buildLabel('Icon'),
                      const SizedBox(height: 12),
                      _buildIconSelector(),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF3B4CCA,
                              ).withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B4CCA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Create Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1B2559),
      ),
    );
  }

  Widget _buildStyledTextField({
    String? hint,
    int maxLines = 1,
    String? initialValue,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF1B2559),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA3AED0), fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF4F7FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF3B4CCA), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return Row(
      children: [
        _buildIconOption(Icons.computer_outlined, true),
        const SizedBox(width: 16),
        _buildIconOption(Icons.chair_outlined, false),
        const SizedBox(width: 16),
        _buildIconOption(Icons.local_shipping_outlined, false),
        const SizedBox(width: 16),
        _buildIconOption(Icons.more_horiz_outlined, false),
      ],
    );
  }

  Widget _buildIconOption(IconData icon, bool isSelected) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3B4CCA) : const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? null : Border.all(color: Colors.transparent),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : const Color(0xFFA3AED0),
      ),
    );
  }
}
