import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constrants.dart';
import '../modules/admin/attendance_management/views/admin_attendance_page.dart'; // Ensure correct path
import '../modules/student/assingment/view/assingment_main_view.dart';
import '../modules/student/facialAttendance/bindings/facial_attendance_binding.dart';
import '../modules/student/facialAttendance/views/facial_attendance_view.dart';
import '../modules/faculty/attendance_management/bindings/faculty_attendance_binding.dart';
import '../modules/faculty/attendance_management/views/faculty_attendance_page.dart';
import '../modules/onboarding/bindings/onbording_binding.dart';
import '../modules/onboarding/views/orboarding_view.dart';
import '../modules/student/attendance/view/attendance_main_view.dart'; // Ensure correct path
import '../modules/auth/views/login_view.dart';
import '../modules/student/grades/view/grades_main_view.dart';
import '../modules/student/help/view/help_view.dart';
import '../modules/student/home/views/home_view.dart';
import '../modules/student/home/bindings/home_binding.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/student/setting/bindings/settings_binding.dart';
import '../modules/student/setting/view/settings_view.dart';
import '../modules/student/syllabus/view/syllabus_main_view.dart';
import 'app_routes.dart';

class RouteProtectionMiddleware extends GetMiddleware {
  final String? requiredRole;

  RouteProtectionMiddleware({this.requiredRole});

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(AppConstants.ACCESS_TOKEN_KEY);
    final String? userRole = prefs.getString(AppConstants.USER_ROLE_KEY);
    final String routeName = route.uri.path;

    if (token == null || token.isEmpty) {
      if (routeName != Routes.LOGIN &&
          routeName != Routes.ONBOARDING &&
          routeName != Routes.SPLASH) {
        return GetNavConfig.fromRoute(Routes.LOGIN);
      }
      return route;
    }

    if (requiredRole != null && userRole != requiredRole) {
      if (userRole == 'student') {
        return GetNavConfig.fromRoute(Routes.HOME);
      } else if (userRole == 'faculty') {
        // Specific redirection for faculty
        return GetNavConfig.fromRoute(Routes.FACULTY_ATTENDANCE); // New route
      } else if (userRole == 'admin') {
        return GetNavConfig.fromRoute(Routes.ADMIN_ATTENDANCE);
      }
      return GetNavConfig.fromRoute(Routes.LOGIN);
    }

    return route;
  }
}

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),

    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
      middlewares: [RouteProtectionMiddleware()],
    ),

    // Student Routes
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),

    GetPage(
      name: Routes.ATTENDANCE,
      page: () => AttendanceMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.SYLLABUS,
      page: () => SyllabusMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.ASSIGNMENTS,
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.TIMETABLE,
      // page: () => const TimetableView(),
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.MESSAGES,
      // page: () => const MessagesView(),
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.EXAMS,
      // page: () => const ExamsView(),
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.LIBRARY,
      // page: () => const LibraryView(),
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.FEES,
      // page: () => const FeesView(),
      page: () => AssignmentsMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),
    GetPage(
      name: Routes.GRADES,
      page: () => GradesMainView(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'student')],
    ),

    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      middlewares: [RouteProtectionMiddleware()],
    ),
    GetPage(
      name: Routes.HELP,
      page: () => HelpView(),
      middlewares: [RouteProtectionMiddleware()],
    ),

    // ... other existing GetPages ...
    GetPage(
      name: Routes.FACIAL_ATTENDANCE, // NEW PAGE
      page: () => const FacialAttendanceView(),
      binding: FacialAttendanceBinding(),
    ),

    // Admin Routes
    GetPage(
      name: Routes.ADMIN_ATTENDANCE,
      page: () => AdminAttendancePage(),
      middlewares: [RouteProtectionMiddleware(requiredRole: 'admin')],
    ),

    // Faculty Routes (NEW)
    GetPage(
      name: Routes.FACULTY_ATTENDANCE, // Define this in app_routes.dart
      page: () => FacultyAttendancePage(),
      binding: FacultyAttendanceBinding(), // New binding
      middlewares: [RouteProtectionMiddleware(requiredRole: 'faculty')],
    ),
  ];
}
