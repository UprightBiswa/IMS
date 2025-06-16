// lib/app/modules/faculty/attendance_management/views/widgets/overall_attendance_summary_card.dart
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
      return Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Attendance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              Text(
                'Monitor and manage your students\' attendance',
                style: TextStyle(fontSize: 12, color: AppColors.greyText),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildInfoSquare(
                      icon: Icons.group_outlined,
                      label: 'Total Students',
                      value: '${summary.totalStudents}',
                      subtext: 'Across 12 classes',
                      iconColor: AppColors.primaryBlue,
                      bgColor: AppColors.lightBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoSquare(
                      icon: Icons.check_circle_outline,
                      label: 'Today\'s Attendance',
                      value: '${summary.presentToday * 100 ~/ summary.totalStudents}%', // Assuming presentToday is actual count
                      subtext: '${summary.presentToday} present',
                      iconColor: AppColors.primaryGreen,
                      bgColor: AppColors.primaryGreen.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildInfoSquare(
                      icon: Icons.person_off_outlined,
                      label: 'Absent Students',
                      value: '${summary.absentStudents}',
                      subtext: '${(summary.absentStudents * 100 / summary.totalStudents).toStringAsFixed(0)}% of total',
                      iconColor: AppColors.primaryRed,
                      bgColor: AppColors.primaryRed.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoSquare(
                      icon: Icons.trending_up_outlined,
                      label: 'Weekly Attendance',
                      value: '${summary.weeklyAttendanceRate}%',
                      subtext: 'Up 1.3%', // Dummy for now
                      iconColor: AppColors.primaryOrange,
                      bgColor: AppColors.primaryOrange.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Students Who < 75% attendance',
                        style: TextStyle(fontSize: 13, color: AppColors.darkText),
                      ),
                      Text(
                        '${summary.belowThresholdStudents} Students',
                        style: TextStyle(fontSize: 13, color: AppColors.primaryRed, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoSquare({
    required IconData icon,
    required String label,
    required String value,
    required String subtext,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: iconColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.greyText),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          Text(
            subtext,
            style: TextStyle(fontSize: 10, color: AppColors.greyText),
          ),
        ],
      ),
    );
  }
}