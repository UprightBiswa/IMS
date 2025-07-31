import 'dart:convert';

StudentCreationResponse studentCreationResponseFromJson(String str) => StudentCreationResponse.fromJson(json.decode(str));
String studentCreationResponseToJson(StudentCreationResponse data) => json.encode(data.toJson());

class StudentCreationResponse {
    StudentData? data;
    String? message;
    bool? success;

    StudentCreationResponse({
        this.data,
        this.message,
        this.success,
    });

    factory StudentCreationResponse.fromJson(Map<String, dynamic> json) => StudentCreationResponse(
        data: json["data"] == null ? null : StudentData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "success": success,
    };
}

class StudentData {
    String? createdAt;
    String? enrollmentDate;
    dynamic graduationDate;
    int? id;
    int? isActive;
    int? semesterId;
    SemesterInfo? semesterInfo;
    String? studentId;
    String? updatedAt;
    int? userId;
    UserInfo? userInfo;

    StudentData({
        this.createdAt,
        this.enrollmentDate,
        this.graduationDate,
        this.id,
        this.isActive,
        this.semesterId,
        this.semesterInfo,
        this.studentId,
        this.updatedAt,
        this.userId,
        this.userInfo,
    });

    factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        createdAt: json["created_at"],
        enrollmentDate: json["enrollment_date"],
        graduationDate: json["graduation_date"],
        id: json["id"],
        isActive: json["is_active"],
        semesterId: json["semester_id"],
        semesterInfo: json["semester_info"] == null ? null : SemesterInfo.fromJson(json["semester_info"]),
        studentId: json["student_id"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "enrollment_date": enrollmentDate,
        "graduation_date": graduationDate,
        "id": id,
        "is_active": isActive,
        "semester_id": semesterId,
        "semester_info": semesterInfo?.toJson(),
        "student_id": studentId,
        "updated_at": updatedAt,
        "user_id": userId,
        "user_info": userInfo?.toJson(),
    };
}

class SemesterInfo {
    String? collegeName;
    String? departmentName;
    String? name;
    int? semesterNumber;

    SemesterInfo({
        this.collegeName,
        this.departmentName,
        this.name,
        this.semesterNumber,
    });

    factory SemesterInfo.fromJson(Map<String, dynamic> json) => SemesterInfo(
        collegeName: json["college_name"],
        departmentName: json["department_name"],
        name: json["name"],
        semesterNumber: json["semester_number"],
    );

    Map<String, dynamic> toJson() => {
        "college_name": collegeName,
        "department_name": departmentName,
        "name": name,
        "semester_number": semesterNumber,
    };
}

class UserInfo {
    String? email;
    String? firstName;
    String? lastName;
    String? username;

    UserInfo({
        this.email,
        this.firstName,
        this.lastName,
        this.username,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
    };
}