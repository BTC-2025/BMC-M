import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/time_entry.dart';
import '../../services/time_tracking_service.dart';
import '../../../crm/widgets/crm_header.dart'; // Reuse for consistency

class TimeTrackingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const TimeTrackingScreen({super.key, this.onBack, this.onMenu});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  late Future<List<TimeEntry>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _refreshEntries();
  }

  void _refreshEntries() {
    setState(() {
      _entriesFuture = TimeTrackingService().getAllEntries();
    });
  }

  Future<void> _addEntry() async {
    // Show Add Entry Dialog or Screen
    // For simplicity, we can just add a mock entry or create a dialog here.
    // Let's create a specialized dialog below.
    await showDialog(
      context: context,
      builder: (context) => const AddTimeEntryDialog(),
    );
    _refreshEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        backgroundColor: const Color(0xFF5B30BA),
        child: const Icon(Icons.timer_outlined, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: CrmHeader(
                title: 'Time Tracking',
                subtitle: 'Monitor Hours & Billables',
                onBack: widget.onBack,
                onMenu: widget.onMenu,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<TimeEntry>>(
                future: _entriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No time entries logged.'));
                  }

                  final entries = snapshot.data!;
                  // Sort by date desc
                  entries.sort((a, b) => b.date.compareTo(a.date));

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF90A4AE,
                              ).withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF5B30BA,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.access_time_filled_rounded,
                                color: Color(0xFF5B30BA),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.description,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF1B2559),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat(
                                      'MMM dd, yyyy',
                                    ).format(entry.date),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFA3AED0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${entry.durationHours} hrs',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF1B2559),
                                  ),
                                ),
                                if (entry.isBillable)
                                  const Text(
                                    'Billable',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTimeEntryDialog extends StatefulWidget {
  const AddTimeEntryDialog({super.key});

  @override
  State<AddTimeEntryDialog> createState() => _AddTimeEntryDialogState();
}

class _AddTimeEntryDialogState extends State<AddTimeEntryDialog> {
  final _descController = TextEditingController();
  final _hoursController = TextEditingController();

  Future<void> _submit() async {
    if (_descController.text.isEmpty || _hoursController.text.isEmpty) return;

    final entry = TimeEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      projectId: 'proj_1', // Hardcoded for simplified dialog
      userId: 'current_user',
      date: DateTime.now(),
      durationHours: double.tryParse(_hoursController.text) ?? 0,
      description: _descController.text,
      isBillable: true,
    );

    await TimeTrackingService().addEntry(entry);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _hoursController,
            decoration: const InputDecoration(labelText: 'Hours'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
