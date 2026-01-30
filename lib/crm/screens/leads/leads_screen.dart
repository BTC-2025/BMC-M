import 'package:flutter/material.dart';
import '../../widgets/crm_header.dart';
import '../../../common/widgets/states.dart';
import '../../models/lead.dart';
import '../../domain/repositories/crm_repository.dart';
import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';
import 'lead_details_screen.dart';
import 'add_edit_lead_screen.dart';

class LeadsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const LeadsScreen({super.key, this.onBack, this.onMenu});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  late final CrmRepository _crmRepository;
  late Future<List<Lead>> _leadsFuture;
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    // In a real app, inject this via GetIt or Provider
    _crmRepository = CrmRepositoryImpl(
      remoteDataSource: CrmRemoteDataSourceImpl(),
    );
    _refreshLeads();
  }

  void _refreshLeads() {
    setState(() {
      _leadsFuture = _crmRepository.getLeads();
    });
  }

  Future<void> _navigateToAddLead() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEditLeadScreen()),
    );
    if (result == true) {
      _refreshLeads();
    }
  }

  Future<void> _navigateToLeadDetails(Lead lead) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeadDetailsScreen(leadId: lead.id),
      ),
    );
    // Refresh regardless, in case details changed status/notes
    _refreshLeads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddLead,
        backgroundColor: const Color(0xFF2E3192),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: CrmHeader(
                title: 'Leads',
                subtitle: 'Manage Sales Opportunities',
                onBack: widget.onBack,
                onMenu: widget.onMenu,
              ),
            ),
            _buildSearchAndFilter(),
            Expanded(child: _buildLeadsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search leads, companies...',
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
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildPillFilter('All', _statusFilter == 'All'),
              ...LeadStatus.values.map(
                (s) => _buildPillFilter(s.label, _statusFilter == s.label),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPillFilter(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            _statusFilter = label;
          });
        },
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
      ),
    );
  }

  Widget _buildLeadsList() {
    return FutureBuilder<List<Lead>>(
      future: _leadsFuture,
      builder: (context, snapshot) {
        // ✅ NEW: Standardized loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingState(message: 'Loading leads...');
        }

        // ✅ NEW: Proper error handling with retry
        if (snapshot.hasError) {
          return ErrorState(
            message: 'Failed to load leads. Please check your connection.',
            onRetry: _refreshLeads,
          );
        }

        // ✅ NEW: Professional empty state with action
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyState(
            title: 'No Leads Found',
            subtitle:
                'Get started by adding a new lead to your sales pipeline.',
            icon: Icons.person_add_rounded,
            iconColor: const Color(0xFF2E3192),
            onAction: _navigateToAddLead,
            actionLabel: 'Add Lead',
          );
        }

        var leads = snapshot.data!;

        // Filter
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          leads = leads
              .where(
                (l) =>
                    l.firstName.toLowerCase().contains(query) ||
                    l.lastName.toLowerCase().contains(query) ||
                    l.company.toLowerCase().contains(query),
              )
              .toList();
        }

        if (_statusFilter != 'All') {
          leads = leads.where((l) => l.status.label == _statusFilter).toList();
        }

        // ✅ NEW: Empty state for filtered results
        if (leads.isEmpty) {
          return const EmptyState(
            title: 'No Matching Leads',
            subtitle: 'Try adjusting your search or filter criteria.',
            icon: Icons.search_off_rounded,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            _refreshLeads();
            await _leadsFuture;
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(flex: 5, child: _buildListHeader('NAME')),
                        Expanded(flex: 3, child: _buildListHeader('STATUS')),
                        Expanded(flex: 2, child: _buildListHeader('VALUE')),
                        const SizedBox(width: 32),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildListItem(context, leads[index]),
                    );
                  }, childCount: leads.length),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        );
      },
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

  Widget _buildListItem(BuildContext context, Lead lead) {
    return GestureDetector(
      onTap: () => _navigateToLeadDetails(lead),
      child: Container(
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
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Name & Company
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: lead.status.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        lead.initials,
                        style: TextStyle(
                          color: lead.status.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lead.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lead.company,
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

            // Status Badge
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lead.status.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    lead.status.label,
                    style: TextStyle(
                      color: lead.status.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

            // Value
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '\$${lead.value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B3674),
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB0BBD5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
