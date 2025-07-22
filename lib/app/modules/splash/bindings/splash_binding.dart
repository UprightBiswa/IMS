// app/modules/splash/bindings/splash_binding.dart
import 'package:get/get.dart';
import '../../profile/controllers/profile_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
