import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio; // Use alias to avoid conflict with GetX
import 'package:flutter/material.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/api_service.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../profile/controllers/profile_controller.dart'; // For snackbar

enum PhotoUploadStatus { initial, selected, uploaded, error }

class PhotoUploadController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ApiService _apiService = ApiService();

  Rxn<XFile> selectedImage = Rxn<XFile>();
  RxBool isUploading = false.obs;
  Rx<PhotoUploadStatus> photoUploadStatus = PhotoUploadStatus.initial.obs;

  @override
  void onInit() {
    super.onInit();
    // Pre-check if photo is already uploaded, though AuthController handles redirection
    // This is more for UI state management if user somehow lands here again.
    if (_authController.currentUser.value?.photoUploaded == true) {
      photoUploadStatus.value = PhotoUploadStatus.uploaded;
      // You might want to display the existing photo here if available via photoUrl
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        // Check file size (max 5MB)
        final fileSize = await image.length();
        if (fileSize > 5 * 1024 * 1024) {
          // 5 MB in bytes
          Get.snackbar(
            "File Size Error",
            "Please select an image smaller than 5MB.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
        selectedImage.value = image;
        photoUploadStatus.value = PhotoUploadStatus.selected;
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> uploadPhoto() async {
    if (selectedImage.value == null) {
      Get.snackbar(
        "No Image",
        "Please select or click a photo to upload.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isUploading.value = true;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      String fileName = selectedImage.value!.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        "photo": await dio.MultipartFile.fromFile(
          selectedImage.value!.path,
          filename: fileName,
        ),
      });

      // Actual API call
      final response = await _apiService.postFormData(
        ApiEndpoints.UPLOAD_PHOTO, // Ensure this endpoint is defined correctly
        formData: formData,
      );
      print("Upload photo response: ${response.data}");
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Update user model and SharedPreferences
        await _authController.updatePhotoUploadStatus("Uploaded");
        photoUploadStatus.value = PhotoUploadStatus.uploaded;

        // ✅ Fetch image immediately after upload
        await profileController.fetchProfileImage();

        Get.back(); // Dismiss dialog
        Get.snackbar(
          "Success",
          "Profile photo uploaded successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to the student's main page (Attendance)
        Get.offAllNamed(Routes.ATTENDANCE);
      } else {
        Get.back(); // Dismiss dialog
        photoUploadStatus.value = PhotoUploadStatus.error;
        Get.snackbar(
          "Upload Failed",
          "Failed to upload profile photo. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error uploading photo: $e");
      Get.back(); // Dismiss dialog
      photoUploadStatus.value = PhotoUploadStatus.error;
      Get.snackbar(
        "Upload Error",
        "An error occurred during upload: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUploading.value = false;
    }
  }
}
