class MilkModel {
  final String cattleId;
  final double quantity; // in Liters
  final String time; // e.g. "Morning", "Evening"
  final String date; // e.g. "YYYY-MM-DD"

  MilkModel({
    required this.cattleId,
    required this.quantity,
    required this.time,
    required this.date,
  });
}
