class FarmModel {
  final String id;
  final String name;
  final int cattleCount;
  final String location;
  final List<Map<String, String>> cameras;
  final String imageUrl;

  const FarmModel({
    required this.id,
    required this.name,
    required this.cattleCount,
    required this.location,
    required this.cameras,
    required this.imageUrl,
  });

  // Convert to dynamic map representation if needed for serialization later
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cattleCount': cattleCount,
      'location': location,
      'cameras': cameras,
      'imageUrl': imageUrl,
    };
  }
}
