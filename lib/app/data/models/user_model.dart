class UserModels {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'faculty', 'admin'
  final String? photoUrl; // Optional

  UserModels({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      id: json['id'].toString(),
      name: '${json['first_name']} ${json['last_name']}'.trim(),
      email: json['email'] as String,
      role: json['role'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
    };
  }
}
