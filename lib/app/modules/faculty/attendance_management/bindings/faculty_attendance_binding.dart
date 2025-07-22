// lib/app/modules/faculty/attendance_management/bindings/faculty_attendance_binding.dart
import 'package:get/get.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../controllers/faculty_attendance_controller.dart';
import '../controllers/faculty_my_attendance_controller.dart';
import '../controllers/faculty_student_attendance_controller.dart';
// import '../controllers/faculty_student_attendance_controller.dart'; // Will be added when student attendance is implemented

class FacultyAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

    Get.lazyPut<FacultyAttendanceController>(
      () => FacultyAttendanceController(),
    );
    Get.lazyPut<FacultyMyAttendanceController>(
      () => FacultyMyAttendanceController(),
    );
    Get.lazyPut<FacultyStudentAttendanceController>(
      () => FacultyStudentAttendanceController(),
    ); // Add this when you create the Student Attendance controller
  }
}