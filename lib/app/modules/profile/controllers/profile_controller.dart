import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final authController = Get.find<AuthController>();


  String get userPhotoUrl => authController.currentUser.value?.photoUrl ?? '';
  String get userName => authController.currentUser.value?.name ?? '';
  String get userEmail => authController.currentUser.value?.email ?? '';


}
