import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/info_card.dart';
import '../../../../widgets/section_title.dart';
import '../controllers/grades_controller.dart';
import '../models/grades_models.dart'; // For ExamStatus enum

class GradesExamsTab extends GetView<GradesController> {
  const GradesExamsTab({super.key});

  Color _getGradeExamStatusColor(GradeExamStatus status) {
    switch (status) {
      case GradeExamStatus.upcoming:
        return AppColors.accentBlue; // Blue for general upcoming
      case GradeExamStatus.finalExam:
        return AppColors.accentBlue; // Blue for Final Exam
      case GradeExamStatus.midTerm:
        return AppColors.accentYellow; // Orange for Mid-Term
    }
  }

  Color _getGradeExamStatusBgColor(GradeExamStatus status) {
    switch (status) {
      case GradeExamStatus.upcoming:
        return AppColors.lightBlue;
      case GradeExamStatus.finalExam:
        return AppColors.lightBlue;
      case GradeExamStatus.midTerm:
        return AppColors.warningYellow.withValues(alpha: .1);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Semester Filter ---
          InfoCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Academic Results',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  //show slected value contoner color
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        controller.selectedSemesterFilter.value,
                        style: TextStyle(color: AppColors.accentBlue),
                      ),
                    ),
                  ),
                ],
              ),

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
              Row(
                spacing: 8,
                children: [
                  _buildExamOverviewItem(
                    'Upcoming',
                    '3',
                    AppColors.primaryBlue,
                  ),
                  _buildExamOverviewItem(
                    'Completed',
                    '5',
                    AppColors.primaryGreen,
                  ),
                  _buildExamOverviewItem(
                    'This Week',
                    '2',
                    AppColors.accentYellow,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // --- Exam Overview ---
          InfoCard(
            backgroundColor: const Color(0xFFFEFBEA),
            border: Border(),
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

                  const Text(
                    'Exam Alert',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dangerRed,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'You have your final exam in 2 days. Don\'t forget to bring calculator and ID card.',
                style: TextStyle(fontSize: 13, color: AppColors.dangerRed),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Upcoming Exams ---
          SectionTitle(title: 'Upcoming Exams'),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.upcomingExams.length,
              itemBuilder: (context, index) {
                final exam = controller.upcomingExams[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildUpcomingExamCard(exam),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- Recent Results (Exams) ---
          SectionTitle(title: 'Recent Results'),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recentResultsExams.length,
              itemBuilder: (context, index) {
                final result = controller.recentResultsExams[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildRecentResultCard(result),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // --- Study Resources (similar to Syllabus, but simplified for Grades) ---
          SectionTitle(title: 'Study Resources'),
          InfoCard(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: GradeStudyResource.dummyList()
                    .length, // Using static dummy list for simplicity here
                itemBuilder: (context, index) {
                  final resource = GradeStudyResource.dummyList()[index];
                  return _buildStudyResourceItem(resource);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Recent Exam Performance Table ---
          SectionTitle(title: 'Recent Exam Performance'),
          InfoCard(
            padding: const EdgeInsets.all(0), // No padding for the table inside
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(2),
                },
                border: TableBorder.symmetric(
                  inside: const BorderSide(
                    color: AppColors.separatorLine,
                    width: 0.5,
                  ),
                ),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    children: [
                      _buildTableHeaderCell('Subject'),
                      _buildTableHeaderCell('Exam Type'),
                      _buildTableHeaderCell('Score'),
                      _buildTableHeaderCell('Status'),
                    ],
                  ),
                  ...controller.recentExamPerformances
                      .map(
                        (performance) => TableRow(
                          children: [
                            _buildTableCell(performance.subject),
                            _buildTableCell(performance.examType),
                            _buildTableCell(performance.score),
                            _buildTableCell(
                              performance.status,
                              textColor: _getPerformanceStatusColor(
                                performance.status,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExamOverviewItem(String label, String value, Color valueColor) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: valueColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildUpcomingExamCard(GradeExam exam) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: _getGradeExamStatusColor(exam.status).withValues(alpha: .8),
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(8),
        color: _getGradeExamStatusBgColor(exam.status),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exam.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _getGradeExamStatusColor(exam.status),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),

                  color: _getGradeExamStatusColor(
                    exam.status,
                  ).withValues(alpha: .10),
                ),
                child: Text(
                  DateFormat('MMM dd').format(exam.dateTime),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getGradeExamStatusColor(exam.status),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // shiw time formate
              Text("02:00 PM - 05:00 PM"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  exam.status == GradeExamStatus.finalExam
                      ? 'Final Exam'
                      : (exam.status == GradeExamStatus.midTerm
                            ? 'Mid-Term'
                            : 'Upcoming'),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getGradeExamStatusColor(exam.status),
                  ),
                ),
              ),
            ],
          ),

          if (exam.location != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.greyText,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      exam.location!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),

          //deviedr
          Divider(height: 1, color: AppColors.settingsCardBorder, thickness: 1),

          if (exam.timeRemaining != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time remaining:', style: TextStyle(fontSize: 12)),
                Text(
                  exam.timeRemaining!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentRed,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentResultCard(GradeExam result) {
    Color scoreColor = AppColors.darkText;
    if (result.remarks != null) {
      if (result.remarks == 'Good' || result.remarks == 'Excellent') {
        scoreColor = AppColors.primaryGreen;
      } else if (result.remarks == 'Average') {
        scoreColor = AppColors.accentYellow;
      } else if (result.remarks == 'Critical') {
        scoreColor = AppColors.dangerRed;
      }
    }

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${result.status == GradeExamStatus.midTerm ? 'Mid-Term' : (result.status == GradeExamStatus.finalExam ? 'Final Exam' : '')} • ${DateFormat('MMM dd, yyyy').format(result.dateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                result.score ?? 'N/A',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
              if (result.remarks != null)
                Text(
                  result.remarks!,
                  style: TextStyle(fontSize: 12, color: scoreColor),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudyResourceItem(GradeStudyResource resource) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(resource.icon, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  resource.lastUpdatedOrCount ?? resource.description,
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
            size: 16,
            color: AppColors.greyText,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTableCell(
    String text, {
    Color? textColor,
    FontWeight? fontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: textColor ?? AppColors.darkText,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
