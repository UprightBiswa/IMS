import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your views and bindings
import '../constants/app_constrants.dart';
import '../modules/admin/attendance_management/views/admin_attendance_page.dart'; // Ensure correct path
import '../modules/faculty/attendance_management/bindings/faculty_attendance_binding.dart';
import '../modules/faculty/attendance_management/views/faculty_attendance_page.dart';
import '../modules/student/attendance/view/attendance_main_view.dart'; // Ensure correct path
import '../modules/auth/views/login_view.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/help/view/help_view.dart';
import '../modules/student/home/views/home_view.dart';
import '../modules/student/home/bindings/home_binding.dart';
import '../modules/settings/view/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/controllers/profile_controller.dart';
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
          routeName != Routes.GET_STARTED &&
          routeName != Routes.SPLASH) {
        return GetNavConfig.fromRoute(Routes.LOGIN);
      }
      return route;
    }

    if (requiredRole != null && userRole != requiredRole) {
      if (userRole == 'student') {
        return GetNavConfig.fromRoute(Routes.HOME);
      } else if (userRole == 'faculty') { // Specific redirection for faculty
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
    GetPage(name: Routes.GET_STARTED, page: () => GetStartedView()),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),

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

    

    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
      middlewares: [RouteProtectionMiddleware()],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      middlewares: [RouteProtectionMiddleware()],
    ),
    GetPage(
      name: Routes.HELP,
      page: () => HelpView(),
      middlewares: [RouteProtectionMiddleware()],
    ),
  ];
}
