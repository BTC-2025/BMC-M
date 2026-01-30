enum ShipmentStatus { inTransit, delivered, delayed, pending }

class Shipment {
  final String id;
  final String origin;
  final String destination;
  final String carrier;
  final ShipmentStatus status;
  final DateTime estimatedArrival;
  final String currentHub;

  Shipment({
    required this.id,
    required this.origin,
    required this.destination,
    required this.carrier,
    required this.status,
    required this.estimatedArrival,
    required this.currentHub,
  });
}
