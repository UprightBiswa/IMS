// lib/app/modules/syllabus/views/tabs/study_resources_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../controllers/syllabus_controller.dart';

class StudyResourcesTab extends GetView<SyllabusController> {
  const StudyResourcesTab({super.key});

  Color _getResourceStatusBgColor(String status) {
    switch (status) {
      case 'Downloaded':
        return AppColors.downloadGreen.withValues(alpha: 0.1);
      case 'Synced':
        return AppColors.syncCloudBlue.withValues(alpha: 0.1);
      case 'Practice':
        return AppColors.primaryOrange.withValues(alpha: 0.1);
      case 'New':
        return AppColors.dangerRed.withValues(alpha: 0.1); // For New quizzes
      case 'Free':
        return AppColors.primaryGreen.withValues(alpha: 0.1);
      default:
        return AppColors.lightGrey; // Fallback
    }
  }

  Color _getResourceStatusTextColor(String status) {
    switch (status) {
      case 'Downloaded':
        return AppColors.downloadGreen;
      case 'Synced':
        return AppColors.syncCloudBlue;
      case 'Practice':
        return AppColors.primaryOrange;
      case 'New':
        return AppColors.dangerRed;
      case 'Free':
        return AppColors.primaryGreen;
      default:
        return AppColors.greyText; // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Study Resources',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),

          Obx(
            () => Text(
              controller.userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText,
              ),
            ),
          ),
          Obx(
            () => Text(
              'Roll No: ${controller.userRollNumber}',
              style: const TextStyle(fontSize: 14, color: AppColors.greyText),
            ),
          ),
          const SizedBox(height: 20),
          // --- Search Bar ---
          TextField(
            decoration: InputDecoration(
              hintText: 'Search books, notes, videos...',
              prefixIcon: const Icon(Icons.search, color: AppColors.greyText),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.lightGrey,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.settingsCardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resource Library',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResourceSummaryItem(
                      'Books',
                      controller.resourceSummary.value.totalBooks.toString(),
                      AppColors.primaryBlue,
                    ),
                    _buildResourceSummaryItem(
                      'Notes',
                      controller.resourceSummary.value.totalNotes.toString(),
                      AppColors.primaryGreen,
                    ),
                    _buildResourceSummaryItem(
                      'Videos',
                      controller.resourceSummary.value.totalVideos.toString(),
                      AppColors.primaryRed,
                    ),
                    _buildResourceSummaryItem(
                      'Practice',
                      controller.resourceSummary.value.totalPractice.toString(),
                      AppColors.accentYellow,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.snackbar('Action', 'Upload Resource');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                      ),
                      child: const Text(
                        'Upload Resource',
                        style: TextStyle(color: AppColors.white, fontSize: 10),
                      ),
                    ),

                    OutlinedButton(
                      onPressed: () {
                        Get.snackbar('Action', 'Sync Cloud');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.backgroundGray,

                        side: const BorderSide(color: AppColors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                      ),
                      child: const Text(
                        'Sync Cloud',
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // --- Filter by Subject ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.settingsCardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //text filter by subject
                Text(
                  'Filter by Subject',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Wrap(
                    spacing: 8.0, // horizontal spacing
                    runSpacing: 8.0, // vertical spacing
                    children: controller.resourceSubjects.map((subject) {
                      return GestureDetector(
                        onTap: () => controller.selectResourceSubject(subject),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedResourceSubject.value ==
                                    subject
                                ? AppColors.primaryBlue
                                : AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  controller.selectedResourceSubject.value ==
                                      subject
                                  ? AppColors.primaryBlue
                                  : AppColors.grey,
                            ),
                          ),
                          child: Text(
                            subject,
                            style: TextStyle(
                              color:
                                  controller.selectedResourceSubject.value ==
                                      subject
                                  ? AppColors.white
                                  : AppColors.darkText,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Filter by Type (All, Books, Notes, Videos, Practice, Links) ---
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildResourceTypeButton('All', 0),
                  _buildResourceTypeButton('Books', 1),
                  _buildResourceTypeButton('Notes', 2),
                  _buildResourceTypeButton('Videos', 3),
                  _buildResourceTypeButton('Practice', 4),
                  _buildResourceTypeButton('Links', 5),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- Recently Accessed Section ---
          _buildInfoCard(
            children: [
              _buildSectionTitle('Recently Accessed'),
              const SizedBox(height: 10),

              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.settingsCardBorder,
                    thickness: 1,
                  ),
                  itemCount: controller.recentlyAccessedResources.length,
                  itemBuilder: (context, index) {
                    final resource =
                        controller.recentlyAccessedResources[index];
                    return _buildResourceListItem(
                      icon: resource.icon,
                      title: resource.title,
                      subtitle: resource.timeAgo,
                      onTap: () =>
                          Get.snackbar('Action', 'Open ${resource.title}'),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Recommended Books/Resources Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Recommended Books'),
              TextButton(
                onPressed: () => Get.snackbar('Action', 'View All Recommended'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recommendedResources.length,
              itemBuilder: (context, index) {
                final resource = controller.recommendedResources[index];
                return _buildDetailedResourceCard(
                  icon: resource.icon,
                  title: resource.title,
                  subtitle: resource.author,
                  description: resource.description,
                  detail1: resource.pagesOrDuration,
                  status: resource.status,
                  onTap: () => Get.snackbar('Action', 'View ${resource.title}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- Study Notes Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Study Notes'),
              TextButton(
                onPressed: () => Get.snackbar('Action', 'View All Notes'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.studyNotes.length,
              itemBuilder: (context, index) {
                final note = controller.studyNotes[index];
                return _buildDetailedResourceCard(
                  icon: note.icon,
                  title: note.title,
                  subtitle: note.authorCourse,
                  description: note.description,
                  detail1: note.pagesOrDuration,
                  status: note.status,
                  onTap: () => Get.snackbar('Action', 'View ${note.title}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- Video Lectures Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Video Lectures'),
              TextButton(
                onPressed: () => Get.snackbar('Action', 'View All Videos'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.videoLectures.length,
              itemBuilder: (context, index) {
                final video = controller.videoLectures[index];
                return _buildDetailedResourceCard(
                  icon: video.icon,
                  title: video.title,
                  subtitle: video.instructorCourse,
                  description: video.description,
                  detail1: video.duration,
                  status: video.status,
                  onTap: () => Get.snackbar('Action', 'Play ${video.title}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- Practice & Quizzes Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Practice & Quizzes'),
              TextButton(
                onPressed: () => Get.snackbar('Action', 'View All Quizzes'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.practiceQuizzes.length,
              itemBuilder: (context, index) {
                final quiz = controller.practiceQuizzes[index];
                return _buildDetailedResourceCard(
                  icon: quiz.icon,
                  title: quiz.title,
                  subtitle: quiz.subjectChapters,
                  description: quiz.description,
                  status: quiz.status,
                  onTap: () => Get.snackbar('Action', 'Start ${quiz.title}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- External Links Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('External Links'),
              TextButton(
                onPressed: () => Get.snackbar('Action', 'View All Links'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.externalLinks.length,
              itemBuilder: (context, index) {
                final link = controller.externalLinks[index];
                return _buildDetailedResourceCard(
                  icon: link.icon,
                  title: link.title,
                  subtitle: link.urlSource,
                  description: link.description,
                  status: link.status,
                  onTap: () =>
                      Get.snackbar('Action', 'Open ${link.title} Link'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceSummaryItem(
    String label,
    String value,
    Color? valueColor,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.darkText,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.greyText),
        ),
      ],
    );
  }

  Widget _buildResourceTypeButton(String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.changeResourceFilter(index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: controller.selectedResourceFilter.value == index
                ? AppColors.primaryBlue
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selectedResourceFilter.value == index
                  ? AppColors.white
                  : AppColors.greyText,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.settingsCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildResourceListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: Row(
          children: [
            Icon(icon, color: AppColors.greyText, size: 24),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedResourceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    String? detail1, // e.g., pages/duration
    String? status,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.settingsCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkText,
                          ),
                        ),
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
                  if (status != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getResourceStatusBgColor(status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getResourceStatusTextColor(status),
                        ),
                      ),
                    ),
                  const Icon(
                    Icons.more_vert,
                    color: AppColors.greyText,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: AppColors.darkText),
              ),
              if (detail1 != null) ...[
                const SizedBox(height: 4),
                Text(
                  detail1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
