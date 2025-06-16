class ApiEndpoints {
  static const String LOGIN = '/api/v1/auth/login';
  static const String REFRESH_TOKEN = '/auth/refresh-token';
  static const String PROFILE = '/api/v1/profile';

  // Example student endpoints
  static const String STUDENT_ATTENDANCE = '/student/attendance';
  static const String STUDENT_LEAVE_REQUEST = '/student/leave-request';

  // Example admin endpoints
  static const String ADMIN_STUDENTS = '/admin/students';
  static const String ADMIN_FACULTY = '/admin/faculty';
  static const String ADMIN_ATTENDANCE_RECORDS = '/admin/attendance-records';
}