class UserModels {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'faculty', 'admin'
  final String? photoUrl; // Optional
  final bool photoUploaded; // NEW FIELD
  final String? firstName; // Added
  final String? lastName; // Added

  UserModels({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
    this.photoUploaded = false,
    this.firstName, // Initialize
    this.lastName, // Initialize
  });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    final String? photoUrl = json['photoUrl'] as String?;
    final bool photoUploaded = photoUrl != null && photoUrl.isNotEmpty;

    final String? firstName =
        json['first_name'] as String?; // Extract first_name
    final String? lastName = json['last_name'] as String?; // Extract last_name

    return UserModels(
      id: json['id'].toString(),
      // Construct name robustly, handling potential nulls for first/last name
      name: '${firstName ?? ''} ${lastName ?? ''}'.trim(),
      email: json['email'] as String,
      role: json['role'] as String,
      photoUrl: photoUrl,
      photoUploaded: photoUploaded,
      firstName: firstName, // Store first_name
      lastName: lastName, // Store last_name
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name, // Keep 'name' for direct use if needed
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
      'photoUploaded': photoUploaded,
      'first_name': firstName, // Include first_name for proper reconstruction
      'last_name': lastName, // Include last_name for proper reconstruction
    };
  }

  // Helper method to create a copy with updated photoUrl and photoUploaded status
  UserModels copyWith({String? photoUrl, bool? photoUploaded}) {
    return UserModels(
      id: id,
      name: name,
      email: email,
      role: role,
      photoUrl: photoUrl ?? this.photoUrl,
      photoUploaded: photoUploaded ?? this.photoUploaded,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
