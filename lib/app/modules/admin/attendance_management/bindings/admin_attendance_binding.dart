// -----------------------------------------------------------------------------
// Bindings (lib/app/modules/admin/leave_management/bindings/admin_leave_binding.dart)
// -----------------------------------------------------------------------------
import 'package:get/get.dart';

import '../../../profile/controllers/profile_controller.dart';
import '../controllers/admin_attendance_controller.dart';


class AdminAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AttendanceDashboardController>(()=>AttendanceDashboardController());
  }
}

