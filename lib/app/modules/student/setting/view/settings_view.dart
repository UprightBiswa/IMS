import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_models.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsCard(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primaryBlue.withValues(
                          alpha: .1,
                        ),
                        backgroundImage: controller.userPhotoUrl.isNotEmpty
                            ? NetworkImage(controller.userPhotoUrl)
                            : null,
                        child: controller.userPhotoUrl.isEmpty
                            ? Text(
                                controller.userName.isNotEmpty
                                    ? controller.userName[0].toUpperCase()
                                    : '',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: AppColors.primaryBlue,
                                ),
                              )
                            : null,
                      );
                    }),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.userName,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.darkText,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.userRoleAndId,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProfileSummaryItem(
                      'OVERALL',
                      '${controller.overallPercentage.value}%',
                      '',
                    ),
                    _buildProfileSummaryItem(
                      'SUBJECTS',
                      '${controller.completedSubjects.value}/5',
                      '',
                    ),
                    _buildProfileSummaryItem(
                      'CHAPTERS',
                      '${controller.completedChapters.value}',
                      '',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Profile',
                      'Edit Profile functionality not implemented yet.',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 20),

            // --- Recent Performance Section ---
            _buildSectionTitle('Recent Performance'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              children: [
                Obx(() {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.performanceMetrics.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.separatorLine,
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    itemBuilder: (context, index) {
                      final metric = controller.performanceMetrics[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  metric.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkText,
                                  ),
                                ),
                                Text(
                                  metric.progressDescription,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getPerformanceStatusBgColor(
                                  metric.status,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                metric.status
                                    .toString()
                                    .split('.')
                                    .last
                                    .capitalizeFirst!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getPerformanceStatusTextColor(
                                    metric.status,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),

            // --- Preferences Section ---
            _buildSectionTitle('Preferences'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              children: [
                Obx(
                  () => _buildToggleSettingItem(
                    icon: Icons.notifications_none,
                    title: 'Push Notifications',
                    subtitle: 'Get updates on progress and deadlines',
                    value: controller.pushNotificationsEnabled.value,
                    onChanged: controller.togglePushNotifications,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildToggleSettingItem(
                    icon: Icons.mail_outline,
                    title: 'Email Reminders',
                    subtitle: 'Weekly progress summaries',
                    value: controller.emailRemindersEnabled.value,
                    onChanged: controller.toggleEmailReminders,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildToggleSettingItem(
                    icon: Icons.light_mode_outlined,
                    title: 'Dark Mode',
                    subtitle: 'Switch to dark theme',
                    value: controller.darkModeEnabled.value,
                    onChanged: controller.toggleDarkMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Account Section ---
            _buildSectionTitle('Account'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              children: [
                _buildNavigationSettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Security',
                  subtitle: 'Manage your account security',
                  onTap: controller.navigateToPrivacySecurity,
                ),
                _buildDivider(),
                _buildNavigationSettingItem(
                  icon: Icons.storage_outlined,
                  title: 'Data & Storage',
                  subtitle: 'Download your data',
                  onTap: controller.navigateToDataStorage,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Support Section ---
            _buildSectionTitle('Support'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              children: [
                _buildNavigationSettingItem(
                  icon: Icons.help_outline,
                  title: 'Help & FAQ',
                  subtitle: 'Need help using the app?',
                  onTap: controller.navigateToHelpFAQ,
                ),
                _buildDivider(),
                _buildNavigationSettingItem(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Help us improve the app',
                  onTap: controller.navigateToSendFeedback,
                ),
                _buildDivider(),
                _buildNavigationSettingItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and info',
                  onTap: controller.navigateToAbout,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Logout Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.confirmLogout, // Use controller's method
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.logoutRed, // Red color for logout
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16),
                ), // Text from image
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for consistent styling ---

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.settingsCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.settingsCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText.withValues(alpha: .7),
        ),
      ),
    );
  }

  Widget _buildProfileSummaryItem(
    String label,
    String value,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.greyText),
          ),
          if (description.isNotEmpty)
            Text(
              description,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.lightGreyText,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToggleSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.greyText),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.darkText,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              onChanged(newValue);
              // Handle permission check immediately for Push Notifications
              if (title == 'Push Notifications' && newValue) {
                controller.togglePushNotifications(
                  newValue,
                ); // Re-trigger permission check
              }
            },
            activeColor: AppColors.primaryBlue,
            inactiveTrackColor: AppColors.lightGrey,
            inactiveThumbColor: AppColors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.iconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.greyText),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.darkText,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyText,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.greyText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.separatorLine,
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  // Helper functions to get colors for performance status
  Color _getPerformanceStatusBgColor(PerformanceStatus status) {
    switch (status) {
      case PerformanceStatus.excellent:
        return AppColors.presentGreen.withValues(alpha: .1);
      case PerformanceStatus.good:
        return AppColors.accentBlue.withValues(alpha: .1);
      case PerformanceStatus.inProgress:
        return AppColors.lateOrange.withValues(alpha: .1);
      case PerformanceStatus.behind:
        return AppColors.dangerRed.withValues(alpha: .1);
    }
  }

  Color _getPerformanceStatusTextColor(PerformanceStatus status) {
    switch (status) {
      case PerformanceStatus.excellent:
        return AppColors.presentGreen;
      case PerformanceStatus.good:
        return AppColors.accentBlue;
      case PerformanceStatus.inProgress:
        return AppColors.lateOrange;
      case PerformanceStatus.behind:
        return AppColors.dangerRed;
    }
  }
}
