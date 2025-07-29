// -----------------------------------------------------------------------------
// NEW MODELS FOR ATTENDANCE MARKING STATUS RESPONSE
// -----------------------------------------------------------------------------

class AttendanceMarkingStatusResponse {
  final AttendanceMarkingData data;
  final bool success;
  final DateTime timestamp;

  AttendanceMarkingStatusResponse({
    required this.data,
    required this.success,
    required this.timestamp,
  });

  factory AttendanceMarkingStatusResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceMarkingStatusResponse(
      data: AttendanceMarkingData.fromJson(json['data']),
      success: json['success'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class AttendanceMarkingData {
  final MarkingSession? markingSession;
  final SessionDetails? sessionDetails;
  final AttendanceStatistics statistics;
  final List<StudentAttendanceDetail> students;

  AttendanceMarkingData({
    this.markingSession,
    this.sessionDetails,
    required this.statistics,
    required this.students,
  });

  factory AttendanceMarkingData.fromJson(Map<String, dynamic> json) {
    return AttendanceMarkingData(
      markingSession: json['marking_session'] != null
          ? MarkingSession.fromJson(json['marking_session'])
          : null,
      sessionDetails: json['session_details'] != null
          ? SessionDetails.fromJson(json['session_details'])
          : null,
      statistics: AttendanceStatistics.fromJson(json['statistics']),
      students: (json['students'] as List)
          .map((i) => StudentAttendanceDetail.fromJson(i))
          .toList(),
    );
  }
}

class MarkingSession {
  final String? completedAt; // Can be null
  final String markingMethod;
  final String? notes; // Can be null
  final String photoPath;
  final String sessionUuid;
  final String startedAt;
  final String status;

  MarkingSession({
    this.completedAt,
    required this.markingMethod,
    this.notes,
    required this.photoPath,
    required this.sessionUuid,
    required this.startedAt,
    required this.status,
  });

  factory MarkingSession.fromJson(Map<String, dynamic> json) {
    return MarkingSession(
      completedAt: json['completed_at'] as String?,
      markingMethod: json['marking_method'] as String,
      notes: json['notes'] as String?,
      photoPath: json['photo_path'] as String,
      sessionUuid: json['session_uuid'] as String,
      startedAt: json['started_at'] as String,
      status: json['status'] as String,
    );
  }
}

class SessionDetails {
  final String courseCode;
  final String courseTitle;
  final String facultyName;
  final String location;
  final String sessionDate;
  final int sessionId;
  final String sessionTime;
  final String topic;

  SessionDetails({
    required this.courseCode,
    required this.courseTitle,
    required this.facultyName,
    required this.location,
    required this.sessionDate,
    required this.sessionId,
    required this.sessionTime,
    required this.topic,
  });

  factory SessionDetails.fromJson(Map<String, dynamic> json) {
    return SessionDetails(
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      facultyName: json['faculty_name'] as String,
      location: json['location'] as String,
      sessionDate: json['session_date'] as String,
      sessionId: json['session_id'] as int,
      sessionTime: json['session_time'] as String,
      topic: json['topic'] as String,
    );
  }
}

class AttendanceStatistics {
  final int absent;
  final double completionPercentage;
  final int excused;
  final int late;
  final int markedStudents;
  final int present;
  final int totalStudents;
  final int unmarkedStudents;

  AttendanceStatistics({
    required this.absent,
    required this.completionPercentage,
    required this.excused,
    required this.late,
    required this.markedStudents,
    required this.present,
    required this.totalStudents,
    required this.unmarkedStudents,
  });

  factory AttendanceStatistics.fromJson(Map<String, dynamic> json) {
    return AttendanceStatistics(
      absent: parseInt(json['absent']),
      completionPercentage: (json['completion_percentage'] ?? 0).toDouble(),
      excused: json['excused'] ?? 0,
      late: json['late'] ?? 0,
      markedStudents: json['marked_students'] ?? 0,
      present: json['present'] ?? 0,
      totalStudents: json['total_students'] ?? 0,
      unmarkedStudents: json['unmarked_students'] ?? 0,
    );
  }
}

int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

class StudentAttendanceDetail {
  final String? email; // Can be null
  final String? markedAt; // Can be null
  final String name;
  final String? notes; // Can be null
  final String
  status; // e.g., 'not_marked', 'present', 'absent', 'late', 'excused'
  final String studentCode;
  final int studentId;

  StudentAttendanceDetail({
    this.email,
    this.markedAt,
    required this.name,
    this.notes,
    required this.status,
    required this.studentCode,
    required this.studentId,
  });

  factory StudentAttendanceDetail.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceDetail(
      email: json['email'] as String?,
      markedAt: json['marked_at'] as String?,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      studentCode: json['student_code'] as String,
      studentId: json['student_id'] as int,
    );
  }
}
