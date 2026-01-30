import 'package:flutter/material.dart';
import '../../models/machine.dart';
import '../../services/machine_service.dart';
import '../../widgets/manufacturing_drawer.dart';

class MachineStatusScreen extends StatefulWidget {
  const MachineStatusScreen({super.key});

  @override
  State<MachineStatusScreen> createState() => _MachineStatusScreenState();
}

class _MachineStatusScreenState extends State<MachineStatusScreen> {
  late Future<List<Machine>> _machinesFuture;

  @override
  void initState() {
    super.initState();
    _machinesFuture = MachineService().getAllMachines();
  }

  void _onDrawerItemTapped(String screenName) {
    Navigator.pop(context);
  }

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
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Machine Status',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: ManufacturingDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: 'Machine Status',
      ),
      body: FutureBuilder<List<Machine>>(
        future: _machinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No machines found'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildMachineCard(snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildMachineCard(Machine machine) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (machine.status) {
      case MachineStatus.running:
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1);
        statusIcon = Icons.settings; // Simulated animation icon
        break;
      case MachineStatus.idle:
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1);
        statusIcon = Icons.pause_circle_outline;
        break;
      case MachineStatus.down:
        statusColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: 0.1);
        statusIcon = Icons.error_outline;
        break;
      case MachineStatus.maintenance:
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withValues(alpha: 0.1);
        statusIcon = Icons.build_circle_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  machine.status.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            machine.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          Text(
            machine.type,
            style: const TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
          ),
          const Divider(),
          _buildMetricRow('Temp', '${machine.temperature}°C'),
          _buildMetricRow('Vib', '${machine.vibration} mm/s'),
          _buildMetricRow('Uptime', '${machine.uptimePercentage}%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3674),
            ),
          ),
        ],
      ),
    );
  }
}
