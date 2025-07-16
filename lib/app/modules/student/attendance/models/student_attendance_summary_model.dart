class StudentAttendanceSummaryModel {
  final double attendanceOverallPercentage;
  final double percentageTotalPresentMonthly;
  final double percentageTotalPresentToday;
  final double percentageTotalPresentWeekly;
  final String rollNumber;
  final String studentName;
  final int totalSessionsEnrolled;
  final int totalSessionsEnrolledMonthly;
  final int totalSessionsEnrolledWeekly;
  final int totalSessionsPresentMonthly;
  final int totalSessionsPresentToday;
  final int totalSessionsPresentWeekly;

  StudentAttendanceSummaryModel({
    required this.attendanceOverallPercentage,
    required this.percentageTotalPresentMonthly,
    required this.percentageTotalPresentToday,
    required this.percentageTotalPresentWeekly,
    required this.rollNumber,
    required this.studentName,
    required this.totalSessionsEnrolled,
    required this.totalSessionsEnrolledMonthly,
    required this.totalSessionsEnrolledWeekly,
    required this.totalSessionsPresentMonthly,
    required this.totalSessionsPresentToday,
    required this.totalSessionsPresentWeekly,
  });

  factory StudentAttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceSummaryModel(
      attendanceOverallPercentage: (json['attendance_overall_percentage'] as num?)?.toDouble() ?? 0.0,
      percentageTotalPresentMonthly: (json['percentage_total_present_monthly'] as num?)?.toDouble() ?? 0.0,
      percentageTotalPresentToday: (json['percentage_total_present_today'] as num?)?.toDouble() ?? 0.0,
      percentageTotalPresentWeekly: (json['percentage_total_present_weekly'] as num?)?.toDouble() ?? 0.0,
      rollNumber: json['roll_number'] as String? ?? 'N/A',
      studentName: json['student_name'] as String? ?? 'N/A',
      totalSessionsEnrolled: json['total_sessions_enrolled'] as int? ?? 0,
      totalSessionsEnrolledMonthly: json['total_sessions_enrolled_monthly'] as int? ?? 0,
      totalSessionsEnrolledWeekly: json['total_sessions_enrolled_weekly'] as int? ?? 0,
      totalSessionsPresentMonthly: json['total_sessions_present_monthly'] as int? ?? 0,
      totalSessionsPresentToday: json['total_sessions_present_today'] as int? ?? 0,
      totalSessionsPresentWeekly: json['total_sessions_present_weekly'] as int? ?? 0,
    );
  }
}
