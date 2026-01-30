import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/lead.dart';
import '../../models/activity_note.dart';

import '../../data/repositories/crm_repository_impl.dart';
import '../../data/datasources/crm_remote_datasource.dart';

class LeadDetailsScreen extends StatefulWidget {
  final String leadId;

  const LeadDetailsScreen({super.key, required this.leadId});

  @override
  State<LeadDetailsScreen> createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen>
    with SingleTickerProviderStateMixin {
  late Future<Lead?> _leadFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final repo = CrmRepositoryImpl(remoteDataSource: CrmRemoteDataSourceImpl());
    _leadFuture = repo.getLeadById(widget.leadId);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'Lead Details',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B2559)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // Navigate to Edit Screen
            },
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<Lead?>(
        future: _leadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Lead not found'));
          }

          final lead = snapshot.data!;
          return Column(
            children: [
              _buildHeader(lead),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(lead),
                    _buildTimelineTab(lead), // Placeholder for now
                    _buildNotesTab(lead), // Placeholder for now
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(Lead lead) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4318FF).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              lead.initials,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lead.fullName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lead.company,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  lead.status.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderAction(Icons.phone_rounded, 'Call', () {}),
                        _buildHeaderAction(Icons.email_rounded, 'Email', () {}),
                        _buildHeaderAction(
                          Icons.calendar_month_rounded,
                          'Meeting',
                          () {},
                        ),
                        _buildHeaderAction(
                          Icons.task_alt_rounded,
                          'Task',
                          () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF4318FF), size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF4318FF),
            unselectedLabelColor: const Color(0xFFA3AED0),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            indicatorColor: const Color(0xFF4318FF),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Activity'),
              Tab(text: 'Notes'),
            ],
          ),
          const Divider(height: 1, color: Color(0xFFE0E5F2)),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Lead lead) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // About Section
        const Text(
          "ABOUT",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA3AED0),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            lead.notes.isNotEmpty ? lead.notes : 'No description provided.',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A5568),
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Details Section (Consolidated)
        const Text(
          "DETAILS",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA3AED0),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailRow(Icons.email_outlined, 'Email', lead.email),
              _buildDivider(),
              _buildDetailRow(Icons.phone_outlined, 'Phone', lead.phone),
              _buildDivider(),
              _buildDetailRow(Icons.link, 'Source', lead.source),
              _buildDivider(),
              _buildDetailRow(Icons.person_outline, 'Owner', 'Sales Rep (Me)'),
              _buildDivider(),
              _buildDetailRow(
                Icons.attach_money,
                'Est. Value',
                '\$${lead.value.toStringAsFixed(2)}',
                isValue: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    bool isValue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFA3AED0)),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF707EAE),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: isValue
                  ? const Color(0xFF4318FF)
                  : const Color(0xFF1B2559),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF4F7FE),
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _buildTimelineTab(Lead lead) {
    if (lead.activities.isEmpty) {
      return const Center(child: Text("No activities found"));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: lead.activities.length,
      itemBuilder: (context, index) {
        final activity = lead.activities[index];
        final isLast = index == lead.activities.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE0E5F2),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _getActivityIcon(activity.type),
                    size: 18,
                    color: const Color(0xFF4318FF),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: const Color(0xFFE0E5F2),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF90A4AE).withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'MMM d, h:mm a',
                          ).format(activity.timestamp),
                          style: const TextStyle(
                            color: Color(0xFFA3AED0),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.description,
                      style: const TextStyle(
                        color: Color(0xFF707EAE),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.call:
        return Icons.phone;
      case ActivityType.email:
        return Icons.email;
      case ActivityType.meeting:
        return Icons.groups;
      case ActivityType.note:
        return Icons.edit_note;
      case ActivityType.statusChange:
        return Icons.swap_horiz;
    }
  }

  Widget _buildNotesTab(Lead lead) {
    // Safety check for hot reload issues if notesList is uninitialized
    try {
      if (lead.notesList.isEmpty) {
        return const Center(child: Text("No notes allowed"));
      }
    } catch (e) {
      return const Center(child: Text("Please Hot Restart app to view notes"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: lead.notesList.length,
      itemBuilder: (context, index) {
        final note = lead.notesList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1), // Light yellow for notes
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFECB3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.authorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFA000), // Amber darker
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    DateFormat('MMM d, yyyy').format(note.timestamp),
                    style: const TextStyle(
                      color: Color(0xFFFFB300),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                note.content,
                style: const TextStyle(
                  color: Color(0xFF5D4037), // Brownish text
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
