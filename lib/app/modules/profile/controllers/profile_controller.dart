import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/api_endpoints.dart';
import '../../../services/api_service.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final ApiService _apiService = ApiService();

  // Observable for storing the image bytes
  final Rxn<Uint8List> profileImageBytes = Rxn<Uint8List>();
  final RxBool isFetchingImage = false.obs;

@override
  void onInit() {
    super.onInit();
    // Fetch image when the controller is initialized, if a URL exists
    if (
        _authController.currentUser.value?.photoUploaded == true) {
      fetchProfileImage();
    }
    // Listen to changes in currentUser's photoUrl (e.g., after upload)
    ever(_authController.currentUser, (_) {
      if (
          _authController.currentUser.value?.photoUploaded == true &&
          profileImageBytes.value == null) { // Only fetch if not already fetched
        fetchProfileImage();
      }
    });
  }
  String get userPhotoUrl => _authController.currentUser.value?.photoUrl ?? '';
  String get userName => _authController.currentUser.value?.name ?? '';
  String get userEmail => _authController.currentUser.value?.email ?? '';


  Future<void> fetchProfileImage() async {
    isFetchingImage.value = true;
    try {
      // Use the getBytes method from ApiService
      final Uint8List bytes = await _apiService.getBytes(ApiEndpoints.GET_PHOTO_FOR_STUDENT);
      profileImageBytes.value = bytes;
    } catch (e) {
      print("Failed to fetch profile image: $e");
      profileImageBytes.value = null; // Clear on error
      Get.snackbar(
        "Image Error",
        "Could not load profile photo.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isFetchingImage.value = false;
    }
  }

}
