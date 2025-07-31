import 'dart:convert';

CourseResponse courseResponseFromJson(String str) => CourseResponse.fromJson(json.decode(str));
String courseResponseToJson(CourseResponse data) => json.encode(data.toJson());

class CourseResponse {
    List<Course>? data;
    String? message;
    String? status;

    CourseResponse({
        this.data,
        this.message,
        this.status,
    });

    factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        data: json["data"] == null ? [] : List<Course>.from(json["data"]!.map((x) => Course.fromJson(x))),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
    };
}

class Course {
    String? courseCode;
    int? credits;
    String? description;
    int? hoursPerWeek;
    int? id;
    bool? isActive;
    bool? isElective;
    int? semesterId;
    String? title;

    Course({
        this.courseCode,
        this.credits,
        this.description,
        this.hoursPerWeek,
        this.id,
        this.isActive,
        this.isElective,
        this.semesterId,
        this.title,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseCode: json["course_code"],
        credits: json["credits"],
        description: json["description"],
        hoursPerWeek: json["hours_per_week"],
        id: json["id"],
        isActive: json["is_active"],
        isElective: json["is_elective"],
        semesterId: json["semester_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "course_code": courseCode,
        "credits": credits,
        "description": description,
        "hours_per_week": hoursPerWeek,
        "id": id,
        "is_active": isActive,
        "is_elective": isElective,
        "semester_id": semesterId,
        "title": title,
    };
}