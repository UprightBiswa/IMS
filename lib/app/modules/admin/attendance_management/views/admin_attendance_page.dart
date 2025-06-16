import 'package:attendance_demo/app/modules/admin/attendance_management/views/tabs/staff_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/admin_attendance_controller.dart';
import '../widgets/summary_card_widget.dart';
import 'tabs/faculty_tab.dart';
import 'tabs/student_tab.dart';

class AdminAttendancePage extends StatelessWidget {
  AdminAttendancePage({super.key});
  final AttendanceDashboardController controller = Get.put(
    AttendanceDashboardController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Attendance Management'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
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
                            label: 'STUDENTS',
                            index: 0,
                            isSelected: controller.selectedTab.value == 0,
                            onTap: () => controller.changeTab(0),
                          ),
                          TopTabButton(
                            label: 'FACULTY',
                            index: 1,
                            isSelected: controller.selectedTab.value == 1,
                            onTap: () => controller.changeTab(1),
                          ),
                          TopTabButton(
                            label: 'STAFF',
                            index: 2,
                            isSelected: controller.selectedTab.value == 2,
                            onTap: () => controller.changeTab(2),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  StudentDashboardTopSection(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return StudentTab();
                case 1:
                  return FacultyTab();
                case 2:
                  return StaffTab();
                default:
                  return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TopTabButton extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const TopTabButton({
    super.key,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),
      ),
    );
  }
}
