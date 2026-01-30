import '../models/shipment.dart';

class LogisticsService {
  static final LogisticsService _instance = LogisticsService._internal();
  factory LogisticsService() => _instance;
  LogisticsService._internal();

  final List<Shipment> _shipments = [
    Shipment(
      id: 'SHP-1001',
      origin: 'Shanghai, CN',
      destination: 'New York, US',
      carrier: 'Maersk',
      status: ShipmentStatus.inTransit,
      estimatedArrival: DateTime.now().add(const Duration(days: 12)),
      currentHub: 'Singapore Port',
    ),
    Shipment(
      id: 'SHP-1002',
      origin: 'Berlin, DE',
      destination: 'London, UK',
      carrier: 'DHL',
      status: ShipmentStatus.delivered,
      estimatedArrival: DateTime.now().subtract(const Duration(days: 2)),
      currentHub: 'Final Destination',
    ),
    Shipment(
      id: 'SHP-1003',
      origin: 'Mumbai, IN',
      destination: 'Dubai, UAE',
      carrier: 'FedEx',
      status: ShipmentStatus.delayed,
      estimatedArrival: DateTime.now().add(const Duration(days: 5)),
      currentHub: 'Customs Check',
    ),
  ];

  Future<List<Shipment>> getShipments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_shipments);
  }
}
