import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/models/user_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../models/settings_models.dart';

class SettingsController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  Rx<UserModels?> currentUser = Rx<UserModels?>(null);

  String get userName => currentUser.value?.name ?? '';
  String get userRoleAndId => 'Roll No: ${currentUser.value?.id ?? 'N/A'}';
  String get userPhotoUrl => currentUser.value?.photoUrl ?? '';

  final RxInt overallPercentage = 82.obs;
  final RxInt completedSubjects = 4.obs;
  final RxInt completedChapters = 43.obs;

  final RxList<PerformanceMetric> performanceMetrics =
      <PerformanceMetric>[].obs;

  final RxBool pushNotificationsEnabled = false.obs;
  final RxBool emailRemindersEnabled = true.obs;
  final RxBool darkModeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
    _loadPerformanceData();
    _loadPreferences();
  }

  void _loadProfileData() {
    currentUser.value = _authController.currentUser.value;
  }

  void _loadPerformanceData() {
    performanceMetrics.value = PerformanceMetric.dummyList();
  }

  Future<void> _loadPreferences() async {
    var status = await Permission.notification.status;
    pushNotificationsEnabled.value = status.isGranted;
    emailRemindersEnabled.value = true;
    darkModeEnabled.value = false;
  }

  Future<void> togglePushNotifications(bool value) async {
    if (value) {
      var status = await Permission.notification.request();
      if (status.isGranted) {
        pushNotificationsEnabled.value = true;
        Get.snackbar('Notifications', 'Push notifications enabled.');
      } else {
        pushNotificationsEnabled.value = false;
        Get.snackbar(
          'Notifications',
          'Permission denied. Please enable in app settings.',
        );
        openAppSettings();
      }
    } else {
      pushNotificationsEnabled.value = false;
      Get.snackbar('Notifications', 'Push notifications disabled.');
    }
  }

  void toggleEmailReminders(bool value) {
    emailRemindersEnabled.value = value;
    Get.snackbar(
      'Email Reminders',
      'Email reminders ${value ? "enabled" : "disabled"}.',
    );
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    Get.snackbar(
      'Dark Mode',
      'Dark mode ${value ? "enabled" : "disabled"}. (UI not fully implemented)',
    );
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void navigateToPrivacySecurity() {
    Get.toNamed(Routes.PRIVACY_SECURITY);
    Get.snackbar('Navigation', 'Navigating to Privacy & Security.');
  }

  void navigateToDataStorage() {
    Get.toNamed(Routes.DATA_STORAGE);
    Get.snackbar('Navigation', 'Navigating to Data & Storage.');
  }

  void navigateToHelpFAQ() {
    Get.toNamed(Routes.HELP_FAQ);
    Get.snackbar('Navigation', 'Navigating to Help & FAQ.');
  }

  void navigateToSendFeedback() {
    Get.toNamed(Routes.SEND_FEEDBACK);
    Get.snackbar('Navigation', 'Navigating to Send Feedback.');
  }

  void navigateToAbout() {
    Get.toNamed(Routes.ABOUT_APP);
    Get.snackbar('Navigation', 'Navigating to About App.');
  }

  void confirmLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _authController.signOut();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
