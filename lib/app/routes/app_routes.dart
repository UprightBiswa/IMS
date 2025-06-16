abstract class Routes {
  Routes._();
  static const SPLASH = '/splash';
  static const GET_STARTED = '/get-started';
  static const LOGIN = '/login';

  // Student Routes
  static const HOME = '/home'; // Student dashboard
  static const ATTENDANCE = '/attendance'; // Student attendance details

  // Admin Routes
  static const ADMIN_ATTENDANCE = '/admin-attendance'; // Admin dashboard

  // Faculty Routes
  // FACULTY_ATTENDANCE
  static const FACULTY_ATTENDANCE = '/faculty-attendance'; // Faculty dashboard

  // Common Routes
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
  static const HELP = '/help';
}
