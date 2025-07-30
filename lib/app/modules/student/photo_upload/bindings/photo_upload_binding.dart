import 'package:get/get.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../controllers/photo_upload_controller.dart';

class PhotoUploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

    Get.lazyPut<PhotoUploadController>(() => PhotoUploadController());
  }
}
