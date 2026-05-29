class AlertModel {
  final String id;
  final String title;
  final String description;
  final String category; // e.g. "Cattle", "Tracking", "Vaccine", "Members"
  final String? imageUrl; // For unauthorized face alerts

  AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
  });
}
