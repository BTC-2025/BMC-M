enum MachineStatus { running, idle, down, maintenance }

class Machine {
  final String id;
  final String name; // e.g. "CNC-01"
  final String type; // e.g. "Lathe"
  final MachineStatus status;
  final double temperature; // Simulated visual metric
  final double vibration; // Simulated visual metric
  final double uptimePercentage;
  final String currentOperator;
  final DateTime lastMaintenance;

  Machine({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    this.temperature = 0.0,
    this.vibration = 0.0,
    this.uptimePercentage = 0.0,
    required this.currentOperator,
    required this.lastMaintenance,
  });
}
