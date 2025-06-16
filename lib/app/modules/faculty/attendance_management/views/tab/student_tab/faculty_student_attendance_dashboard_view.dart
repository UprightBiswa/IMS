// lib/app/modules/faculty/attendance_management/views/faculty_student_attendance_dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';
import '../../../widgets/class_wise_attendance_card.dart';
import '../../../widgets/recent_classes_card.dart';
import '../../../widgets/student_attendance_summary_card.dart';

class FacultyStudentAttendanceDashboardView extends StatelessWidget {
  FacultyStudentAttendanceDashboardView({super.key});

  final FacultyStudentAttendanceController controller =
      Get.find<FacultyStudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.changeStudentSubTab(2); // Go to Mark tab
                },
                icon: const Icon(Icons.edit_note, color: Colors.white),
                label: const Text(
                  'Mark Attendance',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.upload_file_outlined,
                  color: AppColors.primaryBlue,
                ),
                label: const Text(
                  'Upload Image',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const OverallAttendanceSummaryCard(),
        const SizedBox(height: 16),
        const ClassWiseAttendanceCard(),
        const SizedBox(height: 16),
        const RecentClassesCard(),
      ],
    );
  }
}
