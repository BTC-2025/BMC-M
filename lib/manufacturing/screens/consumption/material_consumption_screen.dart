import 'package:flutter/material.dart';
import '../../models/material_consumption.dart';
import '../../services/material_consumption_service.dart';
import '../../widgets/manufacturing_drawer.dart';
import 'add_consumption_log_screen.dart';

class MaterialConsumptionScreen extends StatefulWidget {
  const MaterialConsumptionScreen({super.key});

  @override
  State<MaterialConsumptionScreen> createState() =>
      _MaterialConsumptionScreenState();
}

class _MaterialConsumptionScreenState extends State<MaterialConsumptionScreen> {
  late Future<List<MaterialConsumption>> _logsFuture;

  @override
  void initState() {
    super.initState();
    _logsFuture = MaterialConsumptionService().getConsumptionLogs();
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
          'Material Consumption',
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
        selectedItem:
            'Consumption', // Mapping might need adjustment based on Drawer
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddConsumptionLogScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF2E7D32),
        icon: const Icon(Icons.fact_check, color: Colors.white),
        label: const Text('Log Usage', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<MaterialConsumption>>(
        future: _logsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No consumption logs found'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildLogCard(snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildLogCard(MaterialConsumption log) {
    bool isOverConsumed = log.variance > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                log.itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1B2559),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  log.workOrderId,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric(
                'Planned',
                '${log.plannedQuantity} ${log.uom}',
                Colors.grey,
              ),
              _buildMetric(
                'Actual',
                '${log.actualQuantity} ${log.uom}',
                isOverConsumed ? Colors.red : Colors.green,
              ),
              _buildMetric(
                'Wastage',
                '${log.wastageQuantity} ${log.uom}',
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Logged by: ${log.loggedBy}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              // Variance Indicator
              if (log.variance != 0)
                Text(
                  'Var: ${log.variance > 0 ? '+' : ''}${log.variance} ${log.uom}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isOverConsumed ? Colors.red : Colors.green,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFFA3AED0)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color == Colors.grey ? const Color(0xFF1B2559) : color,
          ),
        ),
      ],
    );
  }
}
