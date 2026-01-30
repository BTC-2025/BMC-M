import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';

class InventoryTaxCurrencyScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const InventoryTaxCurrencyScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: InventoryHeader(
                  title: 'Tax & Currency',
                  subtitle: 'GST, VAT & Multi-Currency',
                  onBack: onBack,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search tax rates...',
                        hintStyle: const TextStyle(
                          color: Color(0xFFA3AED0),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF4A55A2),
                          size: 20,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF4F7FE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildPillFilter('All', true),
                          _buildPillFilter('GST', false),
                          _buildPillFilter('VAT', false),
                          _buildPillFilter('Currency', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 5, child: _buildListHeader('TAX NAME')),
                    Expanded(flex: 3, child: _buildListHeader('TYPE')),
                    Expanded(flex: 2, child: _buildListHeader('RATE')),
                    const SizedBox(width: 32),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildListItem(context, index),
                  );
                }, childCount: 8),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildListHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Color(0xFFA3AED0),
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildPillFilter(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {},
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF6B7FD7),
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFFA3AED0),
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFF6B7FD7)
                : const Color(0xFFE0E5F2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    List<Map<String, dynamic>> taxes = [
      {'name': 'GST Standard', 'type': 'GST', 'rate': 18},
      {'name': 'GST Reduced', 'type': 'GST', 'rate': 5},
      {'name': 'VAT Standard', 'type': 'VAT', 'rate': 20},
      {'name': 'VAT Reduced', 'type': 'VAT', 'rate': 10},
      {'name': 'Sales Tax', 'type': 'Sales', 'rate': 8},
      {'name': 'Zero Rated', 'type': 'GST', 'rate': 0},
      {'name': 'Luxury Tax', 'type': 'Special', 'rate': 28},
      {'name': 'Import Duty', 'type': 'Customs', 'rate': 15},
    ];

    var tax = taxes[index % taxes.length];
    bool isGST = tax['type'] == 'GST';
    bool isVAT = tax['type'] == 'VAT';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isGST
                        ? const Color(0xFFE8F5E9)
                        : (isVAT
                              ? const Color(0xFFE3F2FD)
                              : const Color(0xFFFFF3E0)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.currency_exchange_rounded,
                      color: isGST
                          ? const Color(0xFF4CAF50)
                          : (isVAT
                                ? const Color(0xFF1976D2)
                                : const Color(0xFFEF6C00)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tax['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B2559),
                          fontSize: 14,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Active',
                        style: const TextStyle(
                          color: Color(0xFFA3AED0),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isGST
                    ? const Color(0xFFE8F5E9)
                    : (isVAT
                          ? const Color(0xFFE3F2FD)
                          : const Color(0xFFFFF3E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  tax['type'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isGST
                        ? const Color(0xFF4CAF50)
                        : (isVAT
                              ? const Color(0xFF1976D2)
                              : const Color(0xFFEF6C00)),
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '${tax['rate']}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: Align(
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFB0BBD5),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
