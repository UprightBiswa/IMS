// lib/app/modules/grades/views/tabs/grades_results_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/info_card.dart';
import '../../../../widgets/section_title.dart';
import '../controllers/grades_controller.dart';
import '../models/grades_models.dart';

class GradesResultsTab extends GetView<GradesController> {
  const GradesResultsTab({super.key});

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
          // --- Semester and Course Filters ---
          InfoCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Semester',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 12),
                  Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedResultsView.value,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primaryBlue,
                        ),
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: controller.changeResultsView,
                        items:
                            <String>[
                                  'Spring 2024',
                                  'View Transcript',
                                ] // "Spring 2024" is a view filter, "View Transcript" is an action
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                .toList(),
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

          // --- Semester Summary ---
          SectionTitle(title: 'Semester Summary'),
          InfoCard(
            children: [
              Obx(
                () => _buildSummaryRow(
                  'Total Credits',
                  controller.semesterCreditSummary.value.totalCredits
                      .toString(),
                ),
              ),
              const Divider(
                color: AppColors.separatorLine,
                height: 1,
                thickness: 1,
              ),
              Obx(
                () => _buildSummaryRow(
                  'Subjects Passed',
                  '${controller.semesterCreditSummary.value.subjectsPassed}',
                ),
              ),
              const Divider(
                color: AppColors.separatorLine,
                height: 1,
                thickness: 1,
              ),
              Obx(
                () => _buildSummaryRow(
                  'Credits Earned',
                  controller.semesterCreditSummary.value.creditsEarned
                      .toString(),
                ),
              ),
              const Divider(
                color: AppColors.separatorLine,
                height: 1,
                thickness: 1,
              ),
              Obx(
                () => _buildSummaryRow(
                  'Class Rank',
                  controller.semesterCreditSummary.value.classRank,
                ),
              ),
            ],
          ),

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

  Widget _buildSubjectPerformanceCard(SubjectPerformance subject) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.settingsCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
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
          _buildPerformanceDetailRow(
            'Mid-term',
            '${subject.midTermScore.toStringAsFixed(0)}%',
            AppColors.primaryBlue,
          ),
          const SizedBox(height: 8),
          _buildPerformanceDetailRow(
            'Assignments',
            '${subject.assignmentsScore.toStringAsFixed(0)}%',
            AppColors.primaryBlue,
          ),
          const SizedBox(height: 8),
          _buildPerformanceDetailRow(
            'Attendance',
            '${subject.attendancePercentage.toStringAsFixed(0)}%',
            AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceDetailRow(
    String label,
    String value,
    Color progressBarColor,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.darkText),
          ),
        ),
        Expanded(
          flex: 4,
          child: LinearProgressIndicator(
            value: double.parse(value.replaceAll('%', '')) / 100,
            backgroundColor: AppColors.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText,
              ),
            ),
          ),
        ),
      ],
    );
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

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.darkText),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
