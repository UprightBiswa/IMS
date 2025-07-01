import 'package:get/get.dart';

import '../controllers/assingment_controller.dart';

class AssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignmentController>(() => AssignmentController());
  }
}