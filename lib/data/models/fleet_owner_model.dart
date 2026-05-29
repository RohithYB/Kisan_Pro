class FleetOwnerModel {
  final String id;
  final String name;
  final int alerts;
  final int vehicles;
  final int activeDeliveries;
  final String imageUrl;

  FleetOwnerModel({
    required this.id,
    required this.name,
    required this.alerts,
    required this.vehicles,
    required this.activeDeliveries,
    required this.imageUrl,
  });

  factory FleetOwnerModel.fromJson(Map<String, dynamic> json) {
    return FleetOwnerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alerts: json['alerts'] ?? 0,
      vehicles: json['vehicles'] ?? 0,
      activeDeliveries: json['activeDeliveries'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
