import 'package:flutter/material.dart';
import '../../widgets/crm_header.dart';

class CrmSupportScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CrmSupportScreen({super.key, this.onBack});

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
                child: CrmHeader(
                  title: 'Support Tickets',
                  subtitle: 'Manage Customer Issues',
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
                        hintText: 'Search tickets...',
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
                          _buildPillFilter('Open', false),
                          _buildPillFilter('In Progress', false),
                          _buildPillFilter('High Priority', false),
                          _buildPillFilter('Closed', false),
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
                    Expanded(flex: 5, child: _buildListHeader('SUBJECT')),
                    Expanded(flex: 3, child: _buildListHeader('PRIORITY')),
                    Expanded(flex: 2, child: _buildListHeader('STATUS')),
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
                }, childCount: 10),
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
        selectedColor: const Color(0xFF2E3192),
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
                ? const Color(0xFF2E3192)
                : const Color(0xFFE0E5F2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    List<String> priorities = ['Low', 'Medium', 'High'];
    String priority = priorities[index % 3];
    Color priorityColor = priority == 'High'
        ? Colors.red
        : (priority == 'Medium' ? Colors.orange : Colors.green);

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
                    color: const Color(0xFFF4F7FE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.confirmation_number_outlined,
                      color: Color(0xFF4A55A2),
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
                        'Ticket #${202400 + index}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B2559),
                          fontSize: 14,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Login Issue detected...',
                        style: const TextStyle(
                          color: Color(0xFFA3AED0),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  priority,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Open',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    fontSize: 11,
                  ),
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
