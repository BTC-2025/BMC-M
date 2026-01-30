import 'package:flutter/material.dart';
import '../../widgets/inventory_header.dart';
import 'inventory_product_details_screen.dart';
import 'inventory_edit_product_screen.dart';

class InventoryItemsList extends StatefulWidget {
  final VoidCallback? onBack;

  const InventoryItemsList({super.key, this.onBack});

  @override
  State<InventoryItemsList> createState() => _InventoryItemsListState();
}

class _InventoryItemsListState extends State<InventoryItemsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FE),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(position: _slideAnimation, child: child),
            );
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header Sliver
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: InventoryHeader(
                    title: 'Products',
                    subtitle: 'Manage Inventory Items',
                    onBack: widget.onBack,
                  ),
                ),
              ),

              // Hero Stats Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B4CCA), Color(0xFF5B30BA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B4CCA).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeroStat('Total Items', '1,248'),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _buildHeroStat('Low Stock', '12'),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _buildHeroStat('Value', '\$45.2k'),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Search & Filter Sliver
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
                          hintText: 'Search products...',
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildPillFilter('All', true),
                            _buildPillFilter('Low Stock', false),
                            _buildPillFilter('Out of Stock', false),
                            _buildPillFilter('Active', false),
                            _buildPillFilter('Archived', false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Column Header Sliver
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 32, 40, 16),
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: _buildListHeader('PRODUCT')),
                      Expanded(flex: 2, child: _buildListHeader('PRICE')),
                      Expanded(flex: 2, child: _buildListHeader('STOCK')),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
              ),

              // Product List Sliver
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildListItem(context, index),
                    );
                  }, childCount: 15),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
        selectedColor: const Color(0xFF3B4CCA),
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
                ? const Color(0xFF3B4CCA)
                : const Color(0xFFE0E5F2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    bool isLowStock = index % 3 == 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InventoryProductDetailsScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF90A4AE).withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Styled Image Placeholder
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLowStock
                            ? [const Color(0xFFFFEBEE), const Color(0xFFFFCDD2)]
                            : [
                                const Color(0xFFE3F2FD),
                                const Color(0xFFBBDEFB),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: isLowStock
                          ? const Color(0xFFE53935)
                          : const Color(0xFF1976D2),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'iPhone 15 Pro Max ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                            fontSize: 15,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Expanded(
              flex: 2,
              child: Text(
                '\$${(index + 1) * 25}.00',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B3674),
                  fontSize: 14,
                ),
              ),
            ),

            // Stock Badge
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isLowStock
                          ? const Color(0xFFFFEBEE)
                          : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isLowStock
                                ? const Color(0xFFEF5350)
                                : const Color(0xFF43A047),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${(index + 1) * 10}',
                          style: TextStyle(
                            color: isLowStock
                                ? const Color(0xFFC62828)
                                : const Color(0xFF2E7D32),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action
            SizedBox(
              width: 32,
              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Color(0xFFB0BBD5),
                    size: 24,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InventoryEditProductScreen(),
                        ),
                      );
                    } else if (value == 'delete') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Delete item selected'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: Color(0xFF1B2559),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Edit',
                                style: TextStyle(
                                  color: Color(0xFF1B2559),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Color(0xFFEF5350),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Color(0xFFEF5350),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
