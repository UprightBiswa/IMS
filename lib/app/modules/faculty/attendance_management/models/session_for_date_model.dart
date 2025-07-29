// -----------------------------------------------------------------------------
// NEW MODELS FOR SESSION LIST RESPONSE (for /api/v1/attendance/sessions)
// -----------------------------------------------------------------------------

class SessionListResponse {
  final Pagination pagination;
  final List<SessionItem> sessions;
  final bool success;

  SessionListResponse({
    required this.pagination,
    required this.sessions,
    required this.success,
  });

  factory SessionListResponse.fromJson(Map<String, dynamic> json) {
    return SessionListResponse(
      pagination: Pagination.fromJson(json['data']['pagination']),
      sessions: (json['data']['sessions'] as List)
          .map((i) => SessionItem.fromJson(i))
          .toList(),
      success: json['success'] as bool,
    );
  }
}

class Pagination {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalRecords;

  Pagination({
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
    required this.totalRecords,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      totalPages: json['total_pages'] as int,
      totalRecords: json['total_records'] as int,
    );
  }
}

// This SessionItem is similar to SessionForMarkingModel but directly from the new API
class SessionItem {
  final int attendanceCount;
  final String courseCode;
  final int courseId;
  final String courseTitle;
  final String createdAt;
  final int durationMinutes;
  final String employeeId;
  final String facultyFirstName;
  final int facultyId;
  final String facultyLastName;
  final int id; // This maps to sessionId in SessionForMarkingModel
  final int isActive;
  final String location;
  final String notes;
  final String sessionDate;
  final String sessionTime;
  final String sessionType;
  final String topic;
  final String updatedAt;
  // Note: The new API response does NOT contain 'markingSessionUuid' or 'markingStatus'
  // directly in the session item. These might need to be fetched separately or inferred
  // if they are crucial for the SessionForMarkingModel. For now, I'll map 'id' to 'sessionId'
  // and leave 'markingSessionUuid' and 'markingStatus' as empty/default for SessionForMarkingModel
  // when converting from SessionItem.

  SessionItem({
    required this.attendanceCount,
    required this.courseCode,
    required this.courseId,
    required this.courseTitle,
    required this.createdAt,
    required this.durationMinutes,
    required this.employeeId,
    required this.facultyFirstName,
    required this.facultyId,
    required this.facultyLastName,
    required this.id,
    required this.isActive,
    required this.location,
    required this.notes,
    required this.sessionDate,
    required this.sessionTime,
    required this.sessionType,
    required this.topic,
    required this.updatedAt,
  });

  factory SessionItem.fromJson(Map<String, dynamic> json) {
    return SessionItem(
      attendanceCount: json['attendance_count'] as int,
      courseCode: json['course_code'] as String,
      courseId: json['course_id'] as int,
      courseTitle: json['course_title'] as String,
      createdAt: json['created_at'] as String,
      durationMinutes: json['duration_minutes'] as int,
      employeeId: json['employee_id'] as String,
      facultyFirstName: json['faculty_first_name'] as String,
      facultyId: json['faculty_id'] as int,
      facultyLastName: json['faculty_last_name'] as String,
      id: json['id'] as int,
      isActive: json['is_active'] as int,
      location: json['location'] as String,
      notes: json['notes'] as String,
      sessionDate: json['session_date'] as String,
      sessionTime: json['session_time'] as String,
      sessionType: json['session_type'] as String,
      topic: json['topic'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}