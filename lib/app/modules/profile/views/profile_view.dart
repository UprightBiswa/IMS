import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_drawer.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Get.put for ProfileController if it hasn't been put yet
    // Otherwise, Get.find would be sufficient if it's guaranteed to be initialized
    final ProfileController profileController = Get.put(ProfileController());
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      drawer:
          const CustomDrawer(), // Ensure CustomDrawer is a const widget or remove const if it needs dynamic content
      appBar: const CustomAppBar(title: 'Profile'),
      body: Obx(() {
        // You can retrieve the user model directly from AuthController for display
        final user = authController.currentUser.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Add overall padding
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              const SizedBox(height: 24), // Spacing from top
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    // Profile Avatar
                    Obx(() {
                      if (profileController.isFetchingImage.value) {
                        return CircleAvatar(
                          radius: 60, // Slightly larger radius
                          backgroundColor: Colors.grey.shade200,
                          child:
                              const CircularProgressIndicator(), // Show loading indicator
                        );
                      } else if (profileController.profileImageBytes.value !=
                          null) {
                        return CircleAvatar(
                          radius: 60, // Slightly larger radius
                          backgroundImage: MemoryImage(
                            profileController.profileImageBytes.value!,
                          ), // Use MemoryImage
                        );
                      } else {
                        return CircleAvatar(
                          radius: 60, // Slightly larger radius
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.person,
                            size: 70, // Larger icon
                            color: Colors.grey.shade600,
                          ), // Placeholder icon
                        );
                      }
                    }),
                    // Optional: Add an edit/camera icon overlay for changing photo
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Implement photo change functionality (e.g., show bottom sheet to pick image)
                          Get.snackbar(
                            "Feature",
                            "Photo change functionality coming soon!",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // User Name
              Text(
                profileController.userName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // User Email
              Text(
                profileController.userEmail,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // User ID (if applicable and you want to display it)
              if (user?.id != null && user!.id.isNotEmpty)
                Text(
                  'ID: ${user.id}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 32),

              // Profile Information Cards/ListTiles
              _buildProfileInfoCard(
                context,
                title: 'Role',
                value: user?.role ?? 'N/A',
                icon: Icons.badge,
              ),
              const SizedBox(height: 12),
              _buildProfileInfoCard(
                context,
                title: 'First Name',
                value: user?.firstName ?? 'N/A',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              _buildProfileInfoCard(
                context,
                title: 'Last Name',
                value: user?.lastName ?? 'N/A',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              _buildProfileInfoCard(
                context,
                title: 'Photo Status',
                value: user?.photoUploadStatus ?? 'N/A',
                icon: user?.photoUploaded == true
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_outlined,
                valueColor: user?.photoUploaded == true
                    ? Colors.green
                    : Colors.orange,
              ),
              const SizedBox(height: 32),

              _drawerItem(
                'Facial Attendance',
                () => Get.toNamed(Routes.FACIAL_ATTENDANCE),
              ),
              SizedBox(height: 8),
              _drawerItem('Settings', () => Get.toNamed(Routes.SETTINGS)),
              SizedBox(height: 8),

              _drawerItem('Help', () => Get.toNamed(Routes.HELP)),

              const SizedBox(height: 32),

              // Logout Button
              SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text("Logout", style: TextStyle(fontSize: 16)),
                  onPressed: authController.signOut,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        Colors.red.shade600, // A clear logout color
                    foregroundColor: Colors.white,
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing from bottom
            ],
          ),
        );
      }),
    );
  }

  Widget _drawerItem(String title, VoidCallback onTap) {
    return ListTile(
      tileColor: AppColors.darkBlue,
      leading: const Icon(Icons.add, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
    );
  }

  // Helper method to build consistent info cards
  Widget _buildProfileInfoCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Card(
      margin: EdgeInsets.zero, // Remove default card margin
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: valueColor ?? Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
