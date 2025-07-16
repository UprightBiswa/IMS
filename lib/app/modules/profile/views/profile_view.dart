import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_drawer.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: const CustomAppBar(title: 'Profile'),

      // Profile content
      body: Obx(() {
        return Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: controller.userPhotoUrl.isNotEmpty
                  ? NetworkImage(controller.userPhotoUrl)
                  : null,
              child: controller.userPhotoUrl.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(controller.userName, style: const TextStyle(fontSize: 18)),
            Text(
              controller.userEmail,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              authController.currentUser.value!.id,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: authController.signOut,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
