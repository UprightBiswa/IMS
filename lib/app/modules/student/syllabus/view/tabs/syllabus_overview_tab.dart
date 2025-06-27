// lib/app/modules/syllabus/views/tabs/syllabus_overview_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../../../theme/app_colors.dart';
import '../../../home/widgets/attendance_summary.dart';
import '../../controllers/syllabus_controller.dart';
import '../../models/syllabus_models.dart';
import '../../widgets/recommendad_action_card.dart';

class SyllabusOverviewTab extends GetView<SyllabusController> {
  const SyllabusOverviewTab({super.key});

  Color _getSubjectStatusBgColor(SubjectStatus status) {
    switch (status) {
      case SubjectStatus.good:
        return AppColors.progressGoodBg;
      case SubjectStatus.inProgress:
        return AppColors.progressInProgressBg;
      case SubjectStatus.behind:
        return AppColors.progressBehindBg;
    }
  }

  Color _getSubjectStatusTextColor(SubjectStatus status) {
    switch (status) {
      case SubjectStatus.good:
        return AppColors.primaryGreen;
      case SubjectStatus.inProgress:
        return AppColors.progressInProgressText;
      case SubjectStatus.behind:
        return AppColors.progressBehindText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Profile Overview Section ---
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
                //text syllabus overview
                const Text(
                  'Syllabus Overview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),

                //profile image
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SummaryPersentage(
                      value: controller.syllabusOverviewOverallPercentage.value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSyllabusSummaryItem(
                      '${controller.syllabusOverviewCompletedChapters.value}',
                      "Today's Chapters",
                      AppColors.primaryBlue,
                    ),
                    _buildSyllabusSummaryItem(
                      '${controller.syllabusOverviewThisWeek.value}',
                      'This Week',
                      AppColors.presentGreen,
                    ),
                    _buildSyllabusSummaryItem(
                      '${controller.syllabusOverviewThisMonth.value}',
                      'This Month',
                      AppColors.primaryOrange,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
                child: const Text(
                  'Download Full Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.backgroundGray,

                  side: const BorderSide(color: AppColors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
                child: const Text(
                  'Export to PDF',
                  style: TextStyle(color: AppColors.darkText, fontSize: 10),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.grey),
                  backgroundColor: AppColors.backgroundGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
                child: const Text(
                  'Share Progress',
                  style: TextStyle(color: AppColors.darkText, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // --- Recommended Actions ---
          RecommendedActionsCard(),

          const SizedBox(height: 20),

          // --- Subject-wise Progress ---
          _buildSectionTitle('Subject-wise Progress'),
          const SizedBox(height: 10),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.subjectProgressList.length,
              itemBuilder: (context, index) {
                final subject = controller.subjectProgressList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.settingsCardBorder,
                        width: 1,
                      ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subject.subjectName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkText,
                              ),
                            ),
                            //show text %
                            Text(
                              "${subject.progressPercentage * 100}%",
                              style: TextStyle(
                                color: _getSubjectStatusTextColor(
                                  subject.status,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subject.instructorName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getSubjectStatusBgColor(subject.status),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                subject.status
                                    .toString()
                                    .split('.')
                                    .last
                                    .capitalizeFirst!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getSubjectStatusTextColor(
                                    subject.status,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ${subject.totalChapters} chapters',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                            Text(
                              'Completed: ${subject.completedChapters} chapters',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        LinearProgressIndicator(
                          value: subject.progressPercentage,
                          backgroundColor: AppColors.lightGrey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getSubjectStatusTextColor(subject.status),
                          ),
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.snackbar(
                              'Action',
                              'View Chapters for ${subject.subjectName}',
                            );
                          },
                          child: const Text(
                            'View Chapters',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(height: 20),

          // --- Progress Summary (Overall Progress) ---
          _buildSectionTitle('Progress Summary'),
          const SizedBox(height: 10),
          _buildInfoCard(
            children: [
              Obx(
                () => _buildProgressSummaryRow(
                  'Overall Progress',
                  '${controller.overallProgressSummary.value.overallPercentage.toStringAsFixed(0)}%',
                ),
              ),
              _buildDivider(),
              Obx(
                () => _buildProgressSummaryRow(
                  'Subjects Completed',
                  '${controller.overallProgressSummary.value.subjectsCompleted}/${controller.overallProgressSummary.value.totalSubjects}',
                ),
              ),
              _buildDivider(),
              Obx(
                () => _buildProgressSummaryRow(
                  'Chapters Completed',
                  '${controller.overallProgressSummary.value.chaptersCompleted}/${controller.overallProgressSummary.value.totalChapters}',
                ),
              ),
              _buildDivider(),
              Obx(
                () => _buildProgressSummaryRow(
                  'Estimated Time',
                  controller.overallProgressSummary.value.estimatedTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Last 17 Days Progress (Graph/Bar Chart) ---
          _buildSectionTitle('Last 17 Days Progress'),
          const SizedBox(height: 10),
          _buildInfoCard(
            children: [
              // Dummy graph representation
              SizedBox(
                height: 120,
                child: Obx(() {
                  if (controller.dailyProgressList.isEmpty) {
                    return const Center(child: Text('No daily progress data.'));
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: controller.dailyProgressList.map((data) {
                      return Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 10,
                              height:
                                  data.progressValue *
                                  100, // Scale height from 0-1 to 0-100
                              decoration: BoxDecoration(
                                color: data.progressValue > 0.7
                                    ? AppColors.primaryBlue
                                    : (data.progressValue > 0.4
                                          ? AppColors.accentYellow
                                          : AppColors.dangerRed),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('dd').format(data.date),
                              style: const TextStyle(
                                fontSize: 10,
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat(
                      'MMM dd',
                    ).format(controller.dailyProgressList.first.date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
                  Text(
                    DateFormat(
                      'MMM dd',
                    ).format(controller.dailyProgressList.last.date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Subject Performance (Overall Summary, bottom of syllabus.png) ---
          _buildSectionTitle('Subject Performance'),
          const SizedBox(height: 10),
          _buildInfoCard(
            children: [
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.subjectProgressList.length,
                  itemBuilder: (context, index) {
                    final subject = controller.subjectProgressList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              subject.subjectName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${(subject.progressPercentage * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getSubjectStatusTextColor(
                                    subject.status,
                                  ),
                                  fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }

  Widget _buildSyllabusSummaryItem(
    String value,
    String label,
    Color? valueColor,
  ) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accentYellow.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: valueColor ?? AppColors.darkText,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: valueColor ?? AppColors.greyText,
              ),
            ),
          ],
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
          color: AppColors.darkText.withValues(alpha: .7),
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
            color: Colors.grey.withValues(alpha: .1),
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

  Widget _buildProgressSummaryRow(String label, String value) {
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

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.separatorLine,
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}
