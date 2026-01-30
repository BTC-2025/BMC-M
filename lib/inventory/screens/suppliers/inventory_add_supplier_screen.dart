import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryAddSupplierScreen extends StatelessWidget {
  const InventoryAddSupplierScreen({super.key});

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
                title: 'Add Supplier',
                subtitle: 'Register new partner',
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
                      _buildSectionTitle('Company Details'),
                      const SizedBox(height: 24),
                      _buildLabel('Company Name'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(hint: 'e.g., Global Logistics'),
                      const SizedBox(height: 24),

                      _buildSectionTitle('Contact Information'),
                      const SizedBox(height: 24),
                      _buildLabel('Contact Person'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(hint: 'e.g., John Doe'),
                      const SizedBox(height: 16),
                      _buildLabel('Email Address'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(hint: 'e.g., contact@company.com'),
                      const SizedBox(height: 16),
                      _buildLabel('Phone Number'),
                      const SizedBox(height: 8),
                      _buildStyledTextField(hint: 'e.g., +1 234 567 890'),

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
                            'Register Supplier',
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
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B2559),
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

  Widget _buildStyledTextField({String? hint, int maxLines = 1}) {
    return TextFormField(
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
}
