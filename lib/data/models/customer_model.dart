class CustomerModel {
  final String id;
  final String businessName;
  final String category;
  final String location;
  final String totalOrders;
  final String completionRate;
  final int activeDeliveries;
  final String avatarUrl;
  final String status;
  final String tier;
  final String desc;

  CustomerModel({
    required this.id,
    required this.businessName,
    required this.category,
    required this.location,
    required this.totalOrders,
    required this.completionRate,
    required this.activeDeliveries,
    required this.avatarUrl,
    this.status = "ACTIVE",
    this.tier = "STANDARD VOLUME",
    this.desc = "",
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      businessName: json['businessName'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      totalOrders: json['totalOrders'] ?? '',
      completionRate: json['completionRate'] ?? '',
      activeDeliveries: json['activeDeliveries'] ?? 0,
      avatarUrl: json['avatarUrl'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      tier: json['tier'] ?? 'STANDARD VOLUME',
      desc: json['desc'] ?? '',
    );
  }
}
