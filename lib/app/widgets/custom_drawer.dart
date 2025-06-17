import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/profile/controllers/profile_controller.dart';
import '../routes/app_routes.dart';

class CustomDrawer extends GetView<ProfileController> {
  const CustomDrawer({super.key});

  void onProfileTap() {
    Get.toNamed(Routes.PROFILE);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
        child: Container(
          color: const Color(0xFF0076F9), // Blue background
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              GestureDetector(
                onTap: onProfileTap,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: controller.userPhotoUrl.isNotEmpty
                          ? NetworkImage(controller.userPhotoUrl)
                          : null,
                      child: controller.userPhotoUrl.isEmpty
                          ? const Icon(Icons.person, size: 16)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Btech-123',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'MAIN NAVIGATION',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 16),

              // Main Items
              _drawerItem('Home', () => Get.offAllNamed(Routes.HOME)),
              _drawerItem('Attendance', () => Get.toNamed(Routes.ATTENDANCE)),
              _drawerItem('Timetable', () {}),
              _drawerItem('Assignments', () {}),
              _drawerItem('Announcement', () {}),
              _drawerItem('Syllabus', () {}),
              _drawerItem('Library', () {}),
              _drawerItem('Fees', () {}),
              _drawerItem(
                'Grades',
                () => Get.toNamed(Routes.FACULTY_ATTENDANCE),
              ),

              const Divider(color: Colors.white54, height: 32),

              const Text(
                'ADDITIONAL OPTIONS',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 16),
              _drawerItem('Settings', () => Get.toNamed(Routes.SETTINGS)),
              _drawerItem('Help', () => Get.toNamed(Routes.HELP)),
            ],
          ),
        ),
      );
    });
  }

  Widget _drawerItem(String title, VoidCallback onTap) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
    );
  }
}
