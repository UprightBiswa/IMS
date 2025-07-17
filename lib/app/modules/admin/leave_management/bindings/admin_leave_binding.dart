// -----------------------------------------------------------------------------
// Bindings (lib/app/modules/admin/leave_management/bindings/admin_leave_binding.dart)
// -----------------------------------------------------------------------------
import 'package:get/get.dart';

import '../controllers/admin_leave_controller.dart';

class AdminLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminLeaveController>(
      () => AdminLeaveController(),
    );
  }
}

