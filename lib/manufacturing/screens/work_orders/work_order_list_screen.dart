import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/work_order.dart';
import '../../services/work_order_service.dart';
import '../../widgets/manufacturing_drawer.dart';
import 'work_order_details_screen.dart';
import 'add_work_order_screen.dart';

class WorkOrderListScreen extends StatefulWidget {
  const WorkOrderListScreen({super.key});

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<WorkOrder>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _refreshOrders();
  }

  void _refreshOrders() {
    setState(() {
      _ordersFuture = WorkOrderService().getAllWorkOrders();
    });
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
          'Work Orders',
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF2E7D32),
          unselectedLabelColor: const Color(0xFFA3AED0),
          indicatorColor: const Color(0xFF2E7D32),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'In Progress'),
            Tab(text: 'Planned'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      endDrawer: ManufacturingDrawer(
        onItemTapped: _onDrawerItemTapped,
        selectedItem: 'Work Orders',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWorkOrderScreen()),
          );
        },
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<WorkOrder>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final allOrders = snapshot.data ?? [];

          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrderList(allOrders),
              _buildOrderList(
                allOrders
                    .where((o) => o.status == WorkOrderStatus.inProgress)
                    .toList(),
              ),
              _buildOrderList(
                allOrders
                    .where((o) => o.status == WorkOrderStatus.planned)
                    .toList(),
              ),
              _buildOrderList(
                allOrders
                    .where((o) => o.status == WorkOrderStatus.completed)
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderList(List<WorkOrder> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No work orders found',
          style: TextStyle(color: Color(0xFFA3AED0)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildWorkOrderCard(orders[index]);
      },
    );
  }

  Widget _buildWorkOrderCard(WorkOrder order) {
    Color statusColor;
    Color statusBgColor;

    switch (order.status) {
      case WorkOrderStatus.planned:
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withValues(alpha: 0.1);
        break;
      case WorkOrderStatus.inProgress:
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1);
        break;
      case WorkOrderStatus.qaPending:
        statusColor = Colors.purple;
        statusBgColor = Colors.purple.withValues(alpha: 0.1);
        break;
      case WorkOrderStatus.completed:
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1);
        break;
      case WorkOrderStatus.cancelled:
        statusColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: 0.1);
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkOrderDetailsScreen(order: order),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B2559),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.productName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA3AED0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA3AED0),
                          ),
                        ),
                        Text(
                          '${order.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Due Date',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA3AED0),
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd').format(order.dueDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Assigned',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA3AED0),
                          ),
                        ),
                        Text(
                          order.assignedTo.split(' ')[0],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2559),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: order.completionPercentage,
                backgroundColor: const Color(0xFFF4F7FE),
                color: statusColor,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
