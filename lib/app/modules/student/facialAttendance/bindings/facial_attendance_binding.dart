// lib/app/modules/facial_attendance/bindings/facial_attendance_binding.dart
import 'package:get/get.dart';
import '../controllers/facial_attendance_controller.dart';

class FacialAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacialAttendanceController>(
      () => FacialAttendanceController(),
    );
  }
}