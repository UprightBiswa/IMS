import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? message;
    User? user;

    UserModel({
        this.message,
        this.user,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    String? createdAt;
    String? email;
    String? firstName;
    int? id;
    int? isActive;
    dynamic lastLogin;
    String? lastName;
    String? photoUploadStatus;
    String? role;
    String? updatedAt;
    String? username;

    User({
        this.createdAt,
        this.email,
        this.firstName,
        this.id,
        this.isActive,
        this.lastLogin,
        this.lastName,
        this.photoUploadStatus,
        this.role,
        this.updatedAt,
        this.username,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: json["created_at"],
        email: json["email"],
        firstName: json["first_name"],
        id: json["id"],
        isActive: json["is_active"],
        lastLogin: json["last_login"],
        lastName: json["last_name"],
        photoUploadStatus: json["photo_upload_status"],
        role: json["role"],
        updatedAt: json["updated_at"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "email": email,
        "first_name": firstName,
        "id": id,
        "is_active": isActive,
        "last_login": lastLogin,
        "last_name": lastName,
        "photo_upload_status": photoUploadStatus,
        "role": role,
        "updated_at": updatedAt,
        "username": username,
    };
}