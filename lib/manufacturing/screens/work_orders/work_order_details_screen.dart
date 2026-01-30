import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/work_order.dart';

class WorkOrderDetailsScreen extends StatelessWidget {
  final WorkOrder order;

  const WorkOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.status) {
      case WorkOrderStatus.planned:
        statusColor = Colors.blue;
        break;
      case WorkOrderStatus.inProgress:
        statusColor = Colors.orange;
        break;
      case WorkOrderStatus.qaPending:
        statusColor = Colors.purple;
        break;
      case WorkOrderStatus.completed:
        statusColor = Colors.green;
        break;
      case WorkOrderStatus.cancelled:
        statusColor = Colors.red;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Execution: ${order.orderNumber}',
          style: const TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildStatusHeader(statusColor),
            const SizedBox(height: 24),
            _buildProgressSection(statusColor),
            const SizedBox(height: 24),
            _buildDetailsGrid(),
            const SizedBox(height: 24),
            _buildTimelineSection(),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader(Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              order.status.label.toUpperCase(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            order.productName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Target Quantity: ${order.quantity} Units',
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Production Progress',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B2559),
                ),
              ),
              Text(
                '${(order.completionPercentage * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: order.completionPercentage,
            backgroundColor: const Color(0xFFF4F7FE),
            color: color,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 12),
          Text(
            'Estimated completion by ${DateFormat('MMM dd').format(order.dueDate)}',
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildDetailItem(
          'Assigned Lead',
          order.assignedTo,
          Icons.person_outline,
        ),
        _buildDetailItem(
          'Production Line',
          order.productionLine,
          Icons.settings_input_component_rounded,
        ),
        _buildDetailItem('Priority', order.priority, Icons.flag_outlined),
        _buildDetailItem(
          'Plan ID',
          order.id.split('_').last,
          Icons.assignment_outlined,
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2E7D32), size: 20),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFA3AED0),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1B2559),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    final dateFormat = DateFormat('MMM dd, HH:mm');
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timing Schedule',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 20),
          _buildTimelineRow(
            'Planned Start',
            dateFormat.format(order.startDate),
            true,
          ),
          _buildTimelineRow(
            'Actual Start',
            order.actualStartDate != null
                ? dateFormat.format(order.actualStartDate!)
                : 'Not Started',
            order.actualStartDate != null,
          ),
          _buildTimelineRow(
            'Planned End',
            dateFormat.format(order.dueDate),
            true,
          ),
          _buildTimelineRow(
            'Actual End',
            order.actualEndDate != null
                ? dateFormat.format(order.actualEndDate!)
                : 'In Progress',
            order.actualEndDate != null,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineRow(String label, String time, bool completed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
          ),
          const Spacer(),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF1B2559),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF2E7D32)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Add Job Card',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF2E7D32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Complete Order',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
