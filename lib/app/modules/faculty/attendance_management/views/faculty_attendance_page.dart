import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../../../admin/attendance_management/views/admin_attendance_page.dart';
import '../controllers/faculty_attendance_controller.dart';
import 'tab/faculty_tab/faculty_my_attendance_tab.dart';
import 'tab/student_tab/faculty_student_attendance_tab.dart';

class FacultyAttendancePage extends StatelessWidget {
  FacultyAttendancePage({super.key});

  final FacultyAttendanceController controller = Get.put(
    FacultyAttendanceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Attendance Management'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            Container(
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
                    'Attendance Management',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Manage your attendance and track the attendance of your students.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Obx(() {
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
                              label: 'FACULTY',
                              isSelected: controller.selectedMainTab.value == 0,
                              onTap: () => controller.changeMainTab(0),
                            ),
                            TopTabButton(
                              label: 'STUDENTS',
                              isSelected: controller.selectedMainTab.value == 1,
                              onTap: () => controller.changeMainTab(1),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            Obx(() {
              switch (controller.selectedMainTab.value) {
                case 0:
                  return FacultyMyAttendanceTab();
                case 1:
                  return FacultyStudentAttendanceTab();
                default:
                  return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
