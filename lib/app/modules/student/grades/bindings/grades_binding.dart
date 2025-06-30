// lib/app/modules/grades/bindings/grades_binding.dart
import 'package:get/get.dart';
import '../controllers/grades_controller.dart';

class GradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GradesController>(
      () => GradesController(),
    );
  }
}