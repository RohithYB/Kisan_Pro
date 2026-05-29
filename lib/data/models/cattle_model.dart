class CattleModel {
  final String id;
  final String name;
  final String breed;
  final double weight;
  final String status; // e.g. "Healthy", "Ill", "Critical"

  CattleModel({
    required this.id,
    required this.name,
    required this.breed,
    required this.weight,
    this.status = 'Healthy',
  });
}
