class ApiEndpoints {
  static const String LOGIN = '/api/v1/auth/login';
  static const String REFRESH_TOKEN = '/auth/refresh-token';
  static const String PROFILE = '/api/v1/profile';

  // Example student endpoints
  static const String STUDENT_ATTENDANCE = '/student/attendance';
  static const String STUDENT_LEAVE_REQUEST = '/student/leave-request';

  // Example admin endpoints
  static const String ADMIN_DASHBOARD_STUDENT_MAPP =
      '/api/v1/attendance/dashboard/admin/students_mapp';
  static const String ADMIN_DASHBOARD_FACULTY_MAPP =
      '/api/v1/attendance/dashboard/admin/faculty_mapp';
  static const String ADMIN_DASHBOARD_STAFF_MAPP =
      '/api/v1/attendance/dashboard/admin/staff_mapp';


  // Faculty dashboard endpoints
  static const String FACULTY_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/attendance_mapp';
  static const String FACULTY_LEAVE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/leave_dashboard_mapp';
  static const String FACULTY_STUDENT_ATTENDANCE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_attendance_dashboard_mapp';
  static const String FACULTY_STUDENTWISE_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_studentwise_attendance_mapp';
}
