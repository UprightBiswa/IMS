import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/profile/controllers/profile_controller.dart';
import '../routes/app_routes.dart';

class CustomAppBar extends GetView<ProfileController>
    implements PreferredSizeWidget {
  final String? title;
  final bool isHome;
  final bool showDrawerIcon;

  const CustomAppBar({
    super.key,
    this.title,
    this.isHome = false,
    this.showDrawerIcon = true,
  });

  void onMenuTap(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void onSearchTap() {
    // You can define a search page later
    Get.snackbar("Search", "Search tapped");
  }

  void onNotificationTap() {
    // You can navigate to a notifications page if you create one
    Get.snackbar("Notifications", "Notification tapped");
  }

  void onProfileTap() {
    Get.toNamed(Routes.PROFILE);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isHome ? AppColors.backgroundGray : Colors.white,
      // titleSpacing: 0,
      title: isHome ? null : Text(title ?? ''),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: onSearchTap,
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: onNotificationTap,
        ),
        GestureDetector(
          onTap: onProfileTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(() {
              if (profileController.isFetchingImage.value) {
                return const CircleAvatar(
                  radius: 16,
                  child: CircularProgressIndicator(), // Show loading indicator
                );
              } else if (profileController.profileImageBytes.value != null) {
                return CircleAvatar(
                  radius: 16,
                  backgroundImage: MemoryImage(
                    profileController.profileImageBytes.value!,
                  ), // Use MemoryImage
                );
              } else {
                return const CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.person, size: 16), // Placeholder icon
                );
              }
            }),
            // child: Obx(
            //   () => CircleAvatar(
            //     radius: 16,
            //     backgroundImage: controller.userPhotoUrl.isNotEmpty
            //         ? NetworkImage(controller.userPhotoUrl)
            //         : null,
            //     child: controller.userPhotoUrl.isEmpty
            //         ? const Icon(Icons.person, size: 16)
            //         : null,
            //   ),
            // ),
          ),
        ),
      ],
      leading: showDrawerIcon
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => onMenuTap(context),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
