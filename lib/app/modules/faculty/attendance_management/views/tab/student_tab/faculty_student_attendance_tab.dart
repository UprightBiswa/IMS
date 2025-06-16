// lib/app/modules/faculty/attendance_management/views/faculty_student_attendance_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../admin/attendance_management/views/admin_attendance_page.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';
import 'faculty_student_attendance_dashboard_view.dart';
import 'faculty_student_attendance_mark_view.dart';
import 'faculty_student_attendance_record_view.dart';

class FacultyStudentAttendanceTab extends StatelessWidget {
  FacultyStudentAttendanceTab({super.key});

  final FacultyStudentAttendanceController controller = Get.put(
    FacultyStudentAttendanceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              const SizedBox(height: 10),
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
                        label: 'Dashboard',
                        index: 0,
                        isSelected: controller.selectedStudentSubTab.value == 0,
                        onTap: () => controller.changeStudentSubTab(0),
                      ),
                      TopTabButton(
                        label: 'Record',
                        index: 1,
                        isSelected: controller.selectedStudentSubTab.value == 1,
                        onTap: () => controller.changeStudentSubTab(1),
                      ),
                      TopTabButton(
                        label: 'Mark',
                        index: 2,
                        isSelected: controller.selectedStudentSubTab.value == 2,
                        onTap: () => controller.changeStudentSubTab(2),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        // Content based on selected sub-tab
        Obx(() {
          switch (controller.selectedStudentSubTab.value) {
            case 0:
              return FacultyStudentAttendanceDashboardView();
            case 1:
              return FacultyStudentAttendanceRecordView();
            case 2:
              return FacultyStudentAttendanceMarkView();
            default:
              return Container();
          }
        }),
      ],
    );
  }

  Widget _buildStudentSubTabButton({
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.darkText : AppColors.greyText,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
