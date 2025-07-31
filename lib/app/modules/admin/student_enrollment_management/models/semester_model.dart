import 'dart:convert';

import 'deepartment_model.dart'; // Make sure this path is correct for Department model

SemesterResponse semesterResponseFromJson(String str) =>
    SemesterResponse.fromJson(json.decode(str));
String semesterResponseToJson(SemesterResponse data) =>
    json.encode(data.toJson());

class SemesterResponse {
  List<SemesterData>? data; // Changed from SemesterData? to List<SemesterData>?
  String? message;
  String? status;

  SemesterResponse({this.data, this.message, this.status});

  factory SemesterResponse.fromJson(Map<String, dynamic> json) =>
      SemesterResponse(
        // Map the list directly
        data: json["data"] == null
            ? []
            : List<SemesterData>.from(
                json["data"].map((x) => SemesterData.fromJson(x)),
              ),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class SemesterData {
  String? academicYear;
  String? createdAt;
  Department?
  department; // Assuming Department model is correctly defined in deepartment_model.dart
  int? departmentId;
  String? endDate;
  int? id;
  int? isActive;
  String? name;
  int? semesterNumber;
  String? startDate;
  String? updatedAt;

  SemesterData({
    this.academicYear,
    this.createdAt,
    this.department,
    this.departmentId,
    this.endDate,
    this.id,
    this.isActive,
    this.name,
    this.semesterNumber,
    this.startDate,
    this.updatedAt,
  });

  factory SemesterData.fromJson(Map<String, dynamic> json) => SemesterData(
    academicYear: json["academic_year"],
    createdAt: json["created_at"],
    department: json["department"] == null
        ? null
        : Department.fromJson(json["department"]),
    departmentId: json["department_id"],
    endDate: json["end_date"],
    id: json["id"],
    isActive: json["is_active"],
    name: json["name"],
    semesterNumber: json["semester_number"],
    startDate: json["start_date"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "academic_year": academicYear,
    "created_at": createdAt,
    "department": department?.toJson(),
    "department_id": departmentId,
    "end_date": endDate,
    "id": id,
    "is_active": isActive,
    "name": name,
    "semester_number": semesterNumber,
    "start_date": startDate,
    "updated_at": updatedAt,
  };
}
