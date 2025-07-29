import 'dart:io';
import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../controllers/photo_upload_controller.dart';

class PhotoUploadView extends GetView<PhotoUploadController> {
  PhotoUploadView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Get the user's name to display in the welcome message
    final String userName = authController.currentUser.value?.name ?? 'User';

    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5), // Consistent background color
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'IMS',
                    style: TextStyle(
                      color: Color(0xFF3F51B5),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Upload Your Profile Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'This photo will be used for attendance verification',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, $userName!',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Ensure your face is clearly visible for identity verification.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => GestureDetector(
                  onTap: () {}, // Handled by buttons below
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: controller.selectedImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(controller.selectedImage.value!.path),
                              fit: BoxFit.contain,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 22,
                                child: Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                controller.photoUploadStatus.value ==
                                        PhotoUploadStatus.uploaded
                                    ? 'Upload Complete'
                                    : 'Tap to upload Photo',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      controller.photoUploadStatus.value ==
                                          PhotoUploadStatus.uploaded
                                      ? Colors.grey.shade600
                                      : AppColors.primaryBlue,
                                ),
                              ),
                              if (controller.photoUploadStatus.value !=
                                  PhotoUploadStatus.uploaded)
                                Text(
                                  'PDF, JPG, PNG (max. 5MB)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () =>
                    controller.photoUploadStatus.value ==
                        PhotoUploadStatus.uploaded
                    ? Column(
                        children: [
                          Text(
                            'Photo ready for upload',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          controller.pickImage(ImageSource.gallery),
                      icon: const Icon(
                        Icons.file_upload_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: .2),

                        foregroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFFF5F6FA)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.pickImage(ImageSource.camera),
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Click Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: .2),
                        foregroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFFF5F6FA)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.selectedImage.value != null &&
                            !controller.isUploading.value
                        ? () => controller.uploadPhoto()
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF3F51B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: controller.isUploading.value
                        ? const CircularProgressIndicator(
                            color: Color(0xFF3F51B5),
                          )
                        : Text(
                            'Submit Photo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  controller.selectedImage.value != null &&
                                      !controller.isUploading.value
                                  ? AppColors.primaryBlue
                                  : Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'This photo will be used for facial recognition attendance. Make sure your face is clearly visible and well-lit.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              // *** NEW: Logout option ***
              TextButton(
                onPressed: () {
                  authController.signOut(); // Call signOut from AuthController
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
