class FarmerModel {
  final String id;
  final String name;
  final String location;
  final String joinedDate;
  final String avatarUrl;
  final String alertStatus;
  final int totalCattle;
  final int inventoryItems;

  FarmerModel({
    required this.id,
    required this.name,
    required this.location,
    required this.joinedDate,
    required this.avatarUrl,
    required this.alertStatus,
    required this.totalCattle,
    required this.inventoryItems,
  });

  factory FarmerModel.fromJson(Map<String, dynamic> json) {
    return FarmerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      joinedDate: json['joinedDate'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      alertStatus: json['alertStatus'] ?? '',
      totalCattle: json['totalCattle'] ?? 0,
      inventoryItems: json['inventoryItems'] ?? 0,
    );
  }
}
