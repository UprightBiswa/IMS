import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';
import '../../../widgets/class_wise_attendance_card.dart';
import '../../../widgets/recent_classes_card.dart';
import '../../../widgets/student_attendance_summary_card.dart';
import '../../../widgets/student_dashboard_upload_image.dart';

class FacultyStudentAttendanceDashboardView extends StatelessWidget {
  FacultyStudentAttendanceDashboardView({super.key});

  final FacultyStudentAttendanceController controller =
      Get.find<FacultyStudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.6,
          color: const Color(0xFF5F5D5D).withValues(alpha: .1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Attendance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
          ),
          Text(
            'Monitor and manage your students\' attendance',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
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
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.to(() => StudentDashboardUploadImage());
                  },
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
                      borderRadius: BorderRadius.circular(4),
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
      ),
    );
  }
}
