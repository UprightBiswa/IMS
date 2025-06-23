import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../theme/app_colors.dart';
import '../../../../../../admin/attendance_management/views/admin_attendance_page.dart';
import '../../../../controllers/faculty_student_attendance_controller.dart';
import '../../../../widgets/class_wise_attendance_card.dart';
import '../../../../widgets/class_wise_attendance_list.dart';
import '../../../../widgets/recent_classes_card.dart';
import '../../../../widgets/student_attendance_summary_card.dart';
import '../../../../widgets/student_dashboard_upload_image.dart';
import '../../../../widgets/student_wise_attendance_lsit.dart';

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
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopTabButton(
                    label: 'Overview',
                    isSelected: controller.selectedDashboardTab.value == 0,
                    onTap: () => controller.changeDashboardTab(0),
                  ),
                  TopTabButton(
                    label: 'Classes',
                    isSelected: controller.selectedDashboardTab.value == 1,
                    onTap: () => controller.changeDashboardTab(1),
                  ),
                  TopTabButton(
                    label: 'Students',
                    isSelected: controller.selectedDashboardTab.value == 2,
                    onTap: () => controller.changeDashboardTab(2),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            switch (controller.selectedDashboardTab.value) {
              case 0:
                return _buildOverviewContent();
              case 1:
                return _buildClassesContent();
              case 2:
                return _buildStudentsContent();
              default:
                return Container();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildOverviewContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.isError.value) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      return Column(
        children: [
          const OverallAttendanceSummaryCard(),
          const SizedBox(height: 16),
          const ClassWiseAttendanceCard(),
          const SizedBox(height: 16),
          const RecentClassesCard(),
        ],
      );
    });
  }

  Widget _buildClassesContent() {
    return const ClassWiseAttendanceList();
  }

  Widget _buildStudentsContent() {
    return StudentWiseAttendanceList();
  }
}
