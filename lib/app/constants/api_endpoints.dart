class ApiEndpoints {
  static const String LOGIN = '/api/v1/auth/login';
  static const String registerUser = '/api/v1/auth/register';
  static const String REFRESH_TOKEN = '/auth/refresh-token';
  static const String PROFILE = '/api/v1/profile';

  static const String UPLOAD_PHOTO = '/api/v1/attendance/student/upload_photo';
  static const String GET_PHOTO_FOR_STUDENT =
      '/api/v1/attendance/student/get_photo';

  // Student Attendance Dashboard API
  static const String STUDENT_ATTENDANCE_DASHBOARD =
      '/api/v1/attendance/student/dashboard';
  // Leave Management Endpoints
  static const String STUDENT_LEAVE_APPLICATIONS =
      '/api/v1/leaves/my-applications';
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
  static String ADMIN_REVIEW_LEAVE(int id) =>
      '/api/v1/leaves/admin/review/$id'; // Dynamic endpoint for review

  // {{base_url}}/api/v1/attendance/dashboard/admin/students?academic_year=2025 {{base_url}}/api/v1/attendance/dashboard/admin/student/classwise

  static const String ADMIN_DASHBOARD_STUDENT_MAPP_2 =
      '/api/v1/attendance/dashboard/admin/students';
  static const String ADMIN_DASHBOARD_STUDENT_MAPP_3 =
      '/api/v1/attendance/dashboard/admin/student/classwise';

  // Department Endpoints
  static const String departments = '/api/v1/departments';

  static String semestersByDepartment(int departmentId) {
    print('/api/v1/semesters/department/$departmentId');
    return '/api/v1/semesters/department/$departmentId';
  }  // Ideal endpoint (if it exists)
  static const String allSemesters = '/api/v1/semesters'; // Fallback if semestersByDepartment doesn't exist
  static String semesterDetails(int semesterId) => '/semesters/$semesterId/department'; // To get details of a specific semester including department

  // Course Endpoints
  static String coursesBySemester(int semesterId) => '/api/v1/courses/semester/$semesterId';

  // Student Endpoints
  static const String createStudent = '/api/v1/attendance/students';

  // Course Enrollment Endpoints
  static const String enrollments = '/api/v1/attendance/enrollments';

  // Faculty dashboard endpoints
  static const String FACULTY_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/attendance_mapp';
  static const String FACULTY_LEAVE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/leave_dashboard_mapp';
  static const String FACULTY_STUDENT_ATTENDANCE_DASHBOARD_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_attendance_dashboard_mapp';
  static const String FACULTY_STUDENTWISE_ATTENDANCE_MAPP =
      '/api/v1/attendance/dashboard/faculty/student_studentwise_attendance_mapp';
  // Faculty Student Attendance Marking Endpoints
  static const String FACULTY_TODAY_SESSIONS =
      '/api/v1/attendance/dashboard/faculty/today_sessions';
  // NEW API Endpoint for fetching sessions with filters and pagination
  static const String FACULTY_SESSIONS_FILTERED = '/api/v1/attendance/sessions';

  static String FACULTY_ATTENDANCE_MARKING_STATUS(String uuid) =>
      '/api/v1/attendance/dashboard/faculty/attendance_marking_status/$uuid';
  static const String FACULTY_START_ATTENDANCE_MARKING =
      '/api/v1/attendance/dashboard/faculty/start_attendance_marking';


  // NEW Faculty Check-in/Log Endpoints (PLACEHOLDERS)
  static const String FACULTY_CHECK_IN = '/api/v1/attendance/faculty/check_in';
  static const String FACULTY_CHECK_OUT =
      '/api/v1/attendance/faculty/check_out';
  static const String FACULTY_ATTENDANCE_LOGS =
      '/api/v1/attendance/faculty/mobile/log';
}
