// app/modules/home/bindings/home_binding.dart
import 'package:get/get.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart';

class StudentsAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
  }
}
