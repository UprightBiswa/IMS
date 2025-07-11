// class StudentClassSnapshotModel {
//   final String className;
//   final int avgAttendance;
//   final int totalStudents;
//   final int studentsBelow75;
//   final String status;

//   StudentClassSnapshotModel({
//     required this.className,
//     required this.avgAttendance,
//     required this.totalStudents,
//     required this.studentsBelow75,
//     required this.status,
//   });

//   factory StudentClassSnapshotModel.fromJson(Map<String, dynamic> json) {
//     return StudentClassSnapshotModel(
//       className: json['class_name'],
//       avgAttendance: json['avg_attendance_percentage'],
//       totalStudents: json['total_students'],
//       studentsBelow75: json['students_lt_75'],
//       status: json['status'],
//     );
//   }
// }

// lib/app/modules/attendance_dashboard/models/student_class_snap_shot_model.dart
// class StudentClassSnapshotModel {
//   final String? className;
//   final double? avgAttendance;
//   final int? studentsBelow75Percent;
//   final int? totalStudents;
//   final String? status;

//   // Add other fields from the JSON as needed
//   final String? courseCode;
//   final int? courseId;
//   final int? departmentId;
//   final String? facultyName;
//   final Map<String, dynamic>? attendanceDistribution;
//   final Map<String, dynamic>? performanceMetrics;
//   final Map<String, dynamic>? sessionInfo;
//   final Map<String, dynamic>? todaysAttendance;


//   StudentClassSnapshotModel({
//     this.className,
//     this.avgAttendance,
//     this.studentsBelow75Percent,
//     this.totalStudents,
//     this.status,
//     this.courseCode,
//     this.courseId,
//     this.departmentId,
//     this.facultyName,
//     this.attendanceDistribution,
//     this.performanceMetrics,
//     this.sessionInfo,
//     this.todaysAttendance,
//   });

//   factory StudentClassSnapshotModel.fromJson(Map<String, dynamic> json) {
//     return StudentClassSnapshotModel(
//       className: json['class_name'] as String?,
//       avgAttendance: json['avg_attendance'] as double?,
//       studentsBelow75Percent: json['students_below_75_percent'] as int?,
//       totalStudents: json['total_students'] as int?,
//       status: json['status'] as String?,
//       courseCode: json['course_code'] as String?,
//       courseId: json['course_id'] as int?,
//       departmentId: json['department_id'] as int?,
//       facultyName: json['faculty_name'] as String?,
//       attendanceDistribution: json['attendance_distribution'] as Map<String, dynamic>?,
//       performanceMetrics: json['performance_metrics'] as Map<String, dynamic>?,
//       sessionInfo: json['session_info'] as Map<String, dynamic>?,
//       todaysAttendance: json['todays_attendance'] as Map<String, dynamic>?,
//     );
//   }
// }

class StudentClassSnapshotModel {
  final String? className;
  final double? avgAttendance;
  final int? studentsBelow75Percent;
  final int? totalStudents;
  final String? status; // This will be "good" or "needs_attention" from API
  final String? displayStatusText; // Derived status text for UI (e.g., "> 85%")

  // Add other fields from the JSON as needed if you plan to use them
  final String? courseCode;
  final int? courseId;
  final int? departmentId;
  final String? facultyName;
  final Map<String, dynamic>? attendanceDistribution;
  final Map<String, dynamic>? performanceMetrics;
  final Map<String, dynamic>? sessionInfo;
  final Map<String, dynamic>? todaysAttendance;

  StudentClassSnapshotModel({
    this.className,
    this.avgAttendance,
    this.studentsBelow75Percent,
    this.totalStudents,
    this.status,
    this.displayStatusText, // Initialize derived field
    this.courseCode,
    this.courseId,
    this.departmentId,
    this.facultyName,
    this.attendanceDistribution,
    this.performanceMetrics,
    this.sessionInfo,
    this.todaysAttendance,
  });

  factory StudentClassSnapshotModel.fromJson(Map<String, dynamic> json) {
    final double? avgAtt = (json['avg_attendance'] as num?)?.toDouble();
    String derivedDisplayStatusText;

    if (avgAtt == null) {
      derivedDisplayStatusText = "N/A";
    } else if (avgAtt >= 85) {
      derivedDisplayStatusText = "> 85%";
    } else if (avgAtt >= 75 && avgAtt < 85) {
      derivedDisplayStatusText = "75-84%";
    } else {
      derivedDisplayStatusText = "< 75%";
    }

    return StudentClassSnapshotModel(
      className: json['class_name'] as String?,
      avgAttendance: avgAtt,
      studentsBelow75Percent: json['students_below_75_percent'] as int?,
      totalStudents: json['total_students'] as int?,
      status: json['status'] as String?, // Keep original status from API
      displayStatusText: derivedDisplayStatusText, // Set derived status text
      courseCode: json['course_code'] as String?,
      courseId: json['course_id'] as int?,
      departmentId: json['department_id'] as int?,
      facultyName: json['faculty_name'] as String?,
      attendanceDistribution: json['attendance_distribution'] as Map<String, dynamic>?,
      performanceMetrics: json['performance_metrics'] as Map<String, dynamic>?,
      sessionInfo: json['session_info'] as Map<String, dynamic>?,
      todaysAttendance: json['todays_attendance'] as Map<String, dynamic>?,
    );
  }
}