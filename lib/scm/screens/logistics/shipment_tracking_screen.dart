import 'package:flutter/material.dart';

class ShipmentTrackingScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const ShipmentTrackingScreen({
    super.key,
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFEF6C00),
            size: 20,
          ),
          onPressed: onBack,
        ),
        title: const Text(
          'Track Shipment',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFFEF6C00)),
            onPressed: onMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTrackingSearch(),
            const SizedBox(height: 32),
            _buildTrackingStatus(),
            const SizedBox(height: 32),
            _buildTrackingTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingSearch() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search by tracking number',
            style: TextStyle(color: Color(0xFFA3AED0), fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g. SHP-1001-XYZ',
                    hintStyle: const TextStyle(color: Color(0xFFA3AED0)),
                    filled: true,
                    fillColor: const Color(0xFFF4F7FE),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEF6C00),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStatus() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF6C00), Color(0xFFFF9800)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF6C00).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Current Status',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            'In Transit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusDetail('Origin', 'Shanghai'),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white54,
                size: 20,
              ),
              _buildStatusDetail('Destination', 'New York'),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          _buildStatusDetail(
            'Estimated Delivery',
            'Feb 15, 2024',
            center: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDetail(String label, String value, {bool center = false}) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tracking History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2559),
          ),
        ),
        const SizedBox(height: 20),
        _buildTimelineItem(
          'Arrived at Hub',
          'Chicago Distribution Center',
          'Feb 02, 10:30 AM',
          true,
        ),
        _buildTimelineItem(
          'In Transit',
          'En route to Chicago Hub',
          'Feb 01, 04:15 PM',
          false,
        ),
        _buildTimelineItem(
          'Departed',
          'Shanghai Export Terminal',
          'Jan 31, 09:00 AM',
          false,
        ),
        _buildTimelineItem(
          'Picked Up',
          'Supplier Warehouse',
          'Jan 30, 02:30 PM',
          false,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String subtitle,
    String time,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isLast
                    ? const Color(0xFFEF6C00)
                    : const Color(0xFFA3AED0),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: const Color(0xFFA3AED0).withValues(alpha: 0.3),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isLast
                      ? const Color(0xFFEF6C00)
                      : const Color(0xFF1B2559),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Color(0xFFA3AED0)),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
