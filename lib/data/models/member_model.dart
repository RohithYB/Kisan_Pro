class MemberModel {
  final String id;
  final String name;
  final String role; // e.g. "Caretaker", "Milker", "Veterinarian"
  final String faceImageUrl;

  MemberModel({
    required this.id,
    required this.name,
    required this.role,
    required this.faceImageUrl,
  });
}
