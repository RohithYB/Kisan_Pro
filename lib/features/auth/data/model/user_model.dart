class UserModel {
  final String id;
  final String name;
  final String phone;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  // Helper factory to copy or serialize if needed
  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
    );
  }
}
