class ApiEndpoints {
  static const String LOGIN = '/api/v1/auth/login';
  static const String REFRESH_TOKEN = '/auth/refresh-token';
  static const String PROFILE = '/api/v1/profile';

  // Student Attendance Dashboard API
  static const String STUDENT_ATTENDANCE_DASHBOARD = '/api/v1/attendance/student/dashboard';
  // Leave Management Endpoints
  static const String STUDENT_LEAVE_APPLICATIONS = '/api/v1/leaves/my-applications';
  static const String APPLY_LEAVE = '/api/v1/leaves/apply';


  // Example admin endpoints
  static const String ADMIN_DASHBOARD_STUDENT_MAPP =
      '/api/v1/attendance/dashboard/admin/students_mapp';
  static const String ADMIN_DASHBOARD_FACULTY_MAPP =
      '/api/v1/attendance/dashboard/admin/faculty_mapp';
  static const String ADMIN_DASHBOARD_STAFF_MAPP =
      '/api/v1/attendance/dashboard/admin/staff_mapp';
      // Admin Leave Management Endpoints (NEW)
  static const String ADMIN_ALL_LEAVE_APPLICATIONS = '/api/v1/leaves/admin/all';
  static String ADMIN_REVIEW_LEAVE(int id) => '/api/v1/leaves/admin/review/$id'; // Dynamic endpoint for review



  // {{base_url}}/api/v1/attendance/dashboard/admin/students?academic_year=2025 {{base_url}}/api/v1/attendance/dashboard/admin/student/classwise

  static const String ADMIN_DASHBOARD_STUDENT_MAPP_2 =
      '/api/v1/attendance/dashboard/admin/students';
  static const String ADMIN_DASHBOARD_STUDENT_MAPP_3 =
      '/api/v1/attendance/dashboard/admin/student/classwise';

  // Faculty dashboard endpoints
  static const String FACULTY_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/attendance_mapp';
  static const String FACULTY_LEAVE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/leave_dashboard_mapp';
  static const String FACULTY_STUDENT_ATTENDANCE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_attendance_dashboard_mapp';
  static const String FACULTY_STUDENTWISE_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_studentwise_attendance_mapp';
  
  // NEW Faculty Check-in/Log Endpoints (PLACEHOLDERS)
  static const String FACULTY_CHECK_IN = '/api/v1/attendance/faculty/check_in';
  static const String FACULTY_CHECK_OUT = '/api/v1/attendance/faculty/check_out';
  static const String FACULTY_ATTENDANCE_LOGS = '/api/v1/attendance/faculty/logs';
}
