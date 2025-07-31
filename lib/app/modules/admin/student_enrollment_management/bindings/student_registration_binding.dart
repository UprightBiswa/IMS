import 'package:get/get.dart';

import '../controllers/student_registration_controller.dart';

class StudentRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentRegistrationController>(() => StudentRegistrationController());
  }
}
