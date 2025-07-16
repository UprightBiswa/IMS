class SubjectWiseAttendanceModel {
  final String courseName;
  final String facultyName;
  final double presentPercentage;
  final int presentSessions;
  final int totalSessions;

  SubjectWiseAttendanceModel({
    required this.courseName,
    required this.facultyName,
    required this.presentPercentage,
    required this.presentSessions,
    required this.totalSessions,
  });

  factory SubjectWiseAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SubjectWiseAttendanceModel(
      courseName: json['course_name'] as String? ?? 'N/A',
      facultyName: json['faculty_name'] as String? ?? 'N/A',
      presentPercentage: (json['present_percentage'] as num?)?.toDouble() ?? 0.0,
      presentSessions: json['present_sessions'] as int? ?? 0,
      totalSessions: json['total_sessions'] as int? ?? 0,
    );
  }
}

// For day_wise_attendance, we'll convert the map to a list of objects for easier use in UI
class DailyAttendanceData {
  final DateTime date;
  final double percentage;

  DailyAttendanceData({required this.date, required this.percentage});
}