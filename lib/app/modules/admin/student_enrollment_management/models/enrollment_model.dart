import 'dart:convert';

EnrollmentResponse enrollmentResponseFromJson(String str) => EnrollmentResponse.fromJson(json.decode(str));
String enrollmentResponseToJson(EnrollmentResponse data) => json.encode(data.toJson());

class EnrollmentResponse {
    String? message;
    bool? success;

    EnrollmentResponse({
        this.message,
        this.success,
    });

    factory EnrollmentResponse.fromJson(Map<String, dynamic> json) => EnrollmentResponse(
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
    };
}