// lib/app/modules/grades/views/tabs/grades_overview_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/info_card.dart';
import '../../../../widgets/section_title.dart';
import '../controllers/grades_controller.dart';
import '../models/grades_models.dart';

class GradesOverviewTab extends GetView<GradesController> {
  const GradesOverviewTab({super.key});

  Color _getPerformanceStatusColor(String status) {
    switch (status) {
      case 'Excellent':
        return AppColors.gradeExcellent;
      case 'Good':
        return AppColors.gradeGood;
      case 'Average':
        return AppColors.gradeAverage;
      case 'Critical':
        return AppColors.gradeCritical;
      default:
        return AppColors.greyText;
    }
  }

  Color _getPerformanceStatusBgColor(String status) {
    switch (status) {
      case 'Excellent':
        return AppColors.gradeBgLightGreen;
      case 'Good':
        return AppColors.gradeBgLightGreen; // Use same light green for Good
      case 'Average':
        return AppColors.gradeBgLightOrange;
      case 'Critical':
        return AppColors.gradeBgLightRed;
      default:
        return AppColors.lightGrey;
    }
  }

  IconData _getPerformanceStatusIcon(String status) {
    switch (status) {
      case 'Excellent':
      case 'Good':
        return Icons.check_circle_outline;
      case 'Average':
        return Icons.warning_amber_outlined;
      case 'Critical':
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Academic Results Header & Semester Selector ---
          InfoCard(
            children: [
              Text(
                'Academic Results',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),

              Obx(
                () => Text(
                  controller.selectedResultsSemester.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  controller.selectedResultsCourse.value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar('Action', 'Export Report');
                    },
                    icon: const Icon(
                      Icons.download_outlined,
                      size: 18,
                      color: AppColors.primaryBlue,
                    ),
                    label: const Text(
                      'Export Report',
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar('Action', 'View Transcript');
                    },
                    icon: const Icon(
                      Icons.description_outlined,
                      size: 18,
                      color: AppColors.primaryBlue,
                    ),
                    label: const Text(
                      'View Transcript',
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // --- Student Profile & Overall Progress ---
          InfoCard(
            children: [
              Obx(
                () => Text(
                  controller.userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Obx(
                () => Text(
                  "Current GPA: ${controller.overallGradesSummary.value.currentGPA}",
                ),
              ),
              Obx(
                () => Text(
                  "${controller.overallGradesSummary.value.semester} . Academic Year ${controller.overallGradesSummary.value.academicYear}",
                ),
              ),
              const SizedBox(height: 8),

              Obx(
                () => Text(
                  'Roll No: ${controller.userRollNumber}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyText,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value:
                              controller
                                  .overallGradesSummary
                                  .value
                                  .overallPercentage /
                              100,
                          strokeWidth: 6,
                          backgroundColor: AppColors.lightGrey,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${controller.overallGradesSummary.value.overallPercentage.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkText,
                            ),
                          ),

                          const SizedBox(height: 4),
                          Text(
                            controller.overallGradesSummary.value.overallStatus,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.presentGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                spacing: 8,
                children: [
                  _buildGradesSummaryItem(
                    'Semester Avg',
                    '${controller.overallGradesSummary.value.semesterAvg.toStringAsFixed(0)}%',
                    AppColors.accentBlue,
                  ),
                  _buildGradesSummaryItem(
                    'Mid-Term',
                    '${controller.overallGradesSummary.value.midTermAvg.toStringAsFixed(0)}%',
                    AppColors.accentGreen,
                  ),
                  _buildGradesSummaryItem(
                    'Internals',
                    '${controller.overallGradesSummary.value.internalsAvg.toStringAsFixed(0)}%',
                    AppColors.accentYellow,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // --- Performance Trends (Bar Chart) ---
          InfoCard(
            children: [
              SectionTitle(title: 'Performance Trends'),
              const SizedBox(height: 10),

              SizedBox(
                height: 160,
                child: Obx(() {
                  if (controller.performanceTrends.isEmpty) {
                    return const Center(child: Text('No performance data.'));
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: controller.performanceTrends.map((trend) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 30, // Bar width
                              height: trend.score * 1.5, // Scale height
                              decoration: BoxDecoration(
                                color: _getPerformanceStatusColor(
                                  _getScoreStatus(trend.score),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              trend.subject,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 8,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Recommended Actions (reused from Syllabus logic) ---
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFFFB300), width: 4),
              ),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFEFBEA),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFFFFB300),
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    SectionTitle(
                      title: 'Recommended Actions',
                      padding: EdgeInsetsGeometry.zero,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.academicRecommendations
                        .map((action) => _buildBulletPoint(action.text))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Subject-wise Performance ---
          SectionTitle(title: 'Subject-wise Performance'),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.subjectPerformances.length,
              itemBuilder: (context, index) {
                final subject = controller.subjectPerformances[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildSubjectPerformanceCard(subject),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreStatus(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 70) return 'Average';
    return 'Critical';
  }

  Widget _buildGradesSummaryItem(String label, String value, Color valueColor) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: valueColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.greyText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 4, color: AppColors.darkText),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 10, color: AppColors.darkText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectPerformanceCard(SubjectPerformance subject) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.settingsCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .05),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.subjectName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                  ),
                  Text(
                    subject.instructorName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPerformanceStatusBgColor(subject.status),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getPerformanceStatusIcon(subject.status),
                      size: 14,
                      color: _getPerformanceStatusColor(subject.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${subject.grade} ${subject.percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getPerformanceStatusColor(subject.status),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: subject.percentage / 100,
            backgroundColor: AppColors.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getPerformanceStatusColor(subject.status),
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
