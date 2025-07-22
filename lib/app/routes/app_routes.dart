abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;

  // Student Routes
  static const HOME = _Paths.HOME;
  static const ATTENDANCE = _Paths.ATTENDANCE;
  static const SYLLABUS = _Paths.SYLLABUS;
  static const ASSIGNMENTS = _Paths.ASSIGNMENTS;
  static const SUBMIT_ASSIGNMENT = _Paths.SUBMIT_ASSIGNMENT;
  static const ASSIGNMENT_SUBMISSION = _Paths.ASSIGNMENT_SUBMISSION;
  static const TIMETABLE = _Paths.TIMETABLE;
  static const MESSAGES = _Paths.MESSAGES;
  static const EXAMS = _Paths.EXAMS;
  static const LIBRARY = _Paths.LIBRARY;
  static const FEES = _Paths.FEES;
  static const GRADES = _Paths.GRADES;
  static const FACIAL_ATTENDANCE = _Paths.FACIAL_ATTENDANCE;
  static const SETTINGS = _Paths.SETTINGS;
  static const PRIVACY_SECURITY = _Paths.PRIVACY_SECURITY;
  static const DATA_STORAGE = _Paths.DATA_STORAGE;
  static const HELP_FAQ = _Paths.HELP_FAQ;
  static const SEND_FEEDBACK = _Paths.SEND_FEEDBACK;
  static const ABOUT_APP = _Paths.ABOUT_APP;
  static const HELP = _Paths.HELP;

  // Admin Routes
  static const ADMIN_ATTENDANCE = _Paths.ADMIN_ATTENDANCE;
  static const ADMIN_LEAVE_MANAGEMENT =
      _Paths.ADMIN_LEAVE_MANAGEMENT; // NEW ROUTE

  // Faculty Routes
  static const FACULTY_ATTENDANCE = _Paths.FACULTY_ATTENDANCE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';

  //student
  static const HOME = '/home';
  static const ATTENDANCE = '/attendance';
  static const SYLLABUS = '/syllabus';
  static const ASSIGNMENTS = '/assignments';
  static const ASSIGNMENT_SUBMISSION = '/assignment_submission';
  static const SUBMIT_ASSIGNMENT = '/assignments/submit';
  static const TIMETABLE = '/timetable';
  static const MESSAGES = '/messages';
  static const EXAMS = '/exams';
  static const LIBRARY = '/library';
  static const FEES = '/fees';
  static const GRADES = '/grades';
  static const FACIAL_ATTENDANCE = '/facial-attendance';
  static const SETTINGS = '/settings';
  static const PRIVACY_SECURITY = '/settings/privacy_security';
  static const DATA_STORAGE = '/settings/data_storage';
  static const HELP_FAQ = '/settings/help_faq';
  static const SEND_FEEDBACK = '/settings/send_feedback';
  static const ABOUT_APP = '/settings/about_app';
  static const HELP = '/help';

  //admin
  static const ADMIN_ATTENDANCE = '/admin-attendance';
  static const ADMIN_LEAVE_MANAGEMENT = '/admin-leave-management'; // NEW ROUTE

  //faculty
  static const FACULTY_ATTENDANCE = '/faculty-attendance';

}
