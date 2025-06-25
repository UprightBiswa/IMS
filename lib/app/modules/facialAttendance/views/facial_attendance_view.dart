// lib/app/modules/facial_attendance/views/facial_attendance_view.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../controllers/facial_attendance_controller.dart';

class FacialAttendanceView extends GetView<FacialAttendanceController> {
  const FacialAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: const Text(
          'Facial Attendance',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.darkBlue,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
      ),
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColors.primaryBlue),
                const SizedBox(height: 20),
                Text(
                  controller.statusMessage.value,
                  style: const TextStyle(color: AppColors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: CameraPreview(controller.cameraController!),
            ),
            // Overlay for face frame/guide
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.75 * (4/3), // Approx. aspect ratio of a face
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isBlinkDetected.value ? AppColors.primaryGreen : AppColors.primaryBlue,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(150), // Circular frame for face
                ),
                child: Center(
                  child: Icon(
                    Icons.face_retouching_natural_outlined,
                    color: AppColors.white.withValues(alpha: .5),
                    size: 80,
                  ),
                ),
              ),
            ),
            // Status message at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                color: Colors.black.withValues(alpha: .6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.statusMessage.value,
                      style: const TextStyle(color: AppColors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    if (controller.isCapturing.value)
                      const LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                        backgroundColor: AppColors.grey,
                      ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Left Eye:', style: TextStyle(color: AppColors.white.withValues(alpha: .8), fontSize: 12)),
                            Text('${(controller.leftEyeOpenProb.value * 100).toStringAsFixed(0)}%', style: const TextStyle(color: AppColors.white, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Right Eye:', style: TextStyle(color: AppColors.white.withValues(alpha: .8), fontSize: 12)),
                            Text('${(controller.rightEyeOpenProb.value * 100).toStringAsFixed(0)}%', style: const TextStyle(color: AppColors.white, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}