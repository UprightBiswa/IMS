class UserModels {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'faculty', 'admin'
  final String? photoUrl; // Optional
  final String photoUploadStatus;
  final String? firstName; // Added
  final String? lastName; // Added

  UserModels({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
    this.photoUploadStatus = "",
    this.firstName, // Initialize
    this.lastName, // Initialize
  });

  // Helper getter to check if photo is uploaded
  bool get photoUploaded => photoUploadStatus == "Uploaded";

  factory UserModels.fromJson(Map<String, dynamic> json) {
    final String? photoUrl = json['photoUrl'] as String?;
    final String? firstName = json['first_name'] as String?;
    final String? lastName = json['last_name'] as String?;
    final String photoUploadStatus =
        json['photo_upload_status'] as String? ?? "";

    return UserModels(
      id: json['id'].toString(),
      // Construct name robustly, handling potential nulls for first/last name
      name: '${firstName ?? ''} ${lastName ?? ''}'.trim(),
      email: json['email'] as String,
      role: json['role'] as String,
      photoUrl: photoUrl,
      photoUploadStatus: photoUploadStatus,
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
      'photo_upload_status': photoUploadStatus,
      'first_name': firstName, // Include first_name for proper reconstruction
      'last_name': lastName, // Include last_name for proper reconstruction
    };
  }

  // Helper method to create a copy with updated photoUrl and photoUploaded status
  UserModels copyWith({String? photoUrl, String? photoUploadStatus}) {
    return UserModels(
      id: id,
      name: name,
      email: email,
      role: role,
      photoUrl: photoUrl ?? this.photoUrl,
      photoUploadStatus: photoUploadStatus ?? this.photoUploadStatus,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
