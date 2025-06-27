// lib/app/modules/syllabus/bindings/syllabus_binding.dart
import 'package:get/get.dart';
import '../controllers/syllabus_controller.dart';

class SyllabusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyllabusController>(
      () => SyllabusController(),
    );
  }
}