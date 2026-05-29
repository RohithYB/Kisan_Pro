class VehicleModel {
  final String plateNumber;
  final String driverName;
  final String type;
  final String route;
  final String eta;
  final String cargo;
  final String lastActivity;
  final String? alert;
  final String status;
  final String imageUrl;

  VehicleModel({
    required this.plateNumber,
    required this.driverName,
    required this.type,
    required this.route,
    required this.eta,
    required this.cargo,
    required this.lastActivity,
    this.alert,
    required this.status,
    required this.imageUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      plateNumber: json['plateNumber'] ?? '',
      driverName: json['driverName'] ?? '',
      type: json['type'] ?? '',
      route: json['route'] ?? '',
      eta: json['eta'] ?? '',
      cargo: json['cargo'] ?? '',
      lastActivity: json['lastActivity'] ?? '',
      alert: json['alert'],
      status: json['status'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
