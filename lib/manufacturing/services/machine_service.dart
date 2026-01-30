import '../models/machine.dart';

class MachineService {
  static final MachineService _instance = MachineService._internal();
  factory MachineService() => _instance;
  MachineService._internal();

  final List<Machine> _machines = [
    Machine(
      id: 'm_001',
      name: 'CNC-01',
      type: 'CNC Mill',
      status: MachineStatus.running,
      temperature: 65.4,
      vibration: 2.1,
      uptimePercentage: 98.5,
      currentOperator: 'Dave Wilson',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Machine(
      id: 'm_002',
      name: 'LATHE-03',
      type: 'Lathe',
      status: MachineStatus.idle,
      temperature: 40.2,
      vibration: 0.5,
      uptimePercentage: 85.0,
      currentOperator: 'Pending Assign',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 45)),
    ),
    Machine(
      id: 'm_003',
      name: 'PRESS-01',
      type: 'Hydraulic Press',
      status: MachineStatus.down,
      temperature: 25.0,
      vibration: 0.0,
      uptimePercentage: 60.2,
      currentOperator: 'N/A',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Machine(
      id: 'm_004',
      name: 'INJECT-05',
      type: 'Injection Molder',
      status: MachineStatus.maintenance,
      temperature: 22.0,
      vibration: 0.0,
      uptimePercentage: 92.1,
      currentOperator: 'Tech: Sarah',
      lastMaintenance: DateTime.now(),
    ),
  ];

  Future<List<Machine>> getAllMachines() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.from(_machines);
  }
}
