import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class OverallAttendanceSummaryCard extends StatelessWidget {
  const OverallAttendanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyStudentAttendanceController>();

    return Obx(() {
      final summary = controller.overallSummary.value;
      if (summary == null) return SizedBox.shrink();
      final int total = summary.totalStudents == 0 ? 1 : summary.totalStudents;
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1.6, color: const Color(0xFFEAEBEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Attendance',
              style: TextStyle(fontSize: 12, color: AppColors.darkText),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildInfoSquare(
                    label: 'present',
                    value: '${(summary.presentToday * 100 ~/ total)}%',

                    iconColor: AppColors.accentGreen,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInfoSquare(
                    label: 'Absent',
                    value: '${(summary.absentStudents * 100 ~/ total)}%',
                    iconColor: AppColors.accentRed,
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: _buildInfoSquare(
                    label: 'late',
                    value: '${(summary.lateStudent * 100 ~/ total)}%',
                    iconColor: AppColors.accentYellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students Who < 75% attendance',
                  style: TextStyle(fontSize: 10, color: AppColors.darkText),
                ),
                Text(
                  '${summary.belowThresholdStudents} Students',
                  style: TextStyle(fontSize: 10, color: AppColors.primaryRed),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// show line pregeress bar black cor
            LinearProgressIndicator(
              value: summary.weeklyAttendanceRate / 100,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.grey[300],
              color: AppColors.primaryBlue,
            ),

            const SizedBox(height: 16),

            //show total stuent
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Students',
                  style: TextStyle(fontSize: 12, color: AppColors.darkText),
                ),
                Text(
                  '${summary.totalStudents}',
                  style: TextStyle(fontSize: 12, color: AppColors.darkText),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoSquare({
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: AppColors.greyText),
          ),
          Row(
            children: [
              //dot color
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(fontSize: 12, color: AppColors.darkText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
