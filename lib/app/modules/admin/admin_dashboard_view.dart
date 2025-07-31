import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'attendance_management/views/admin_attendance_page.dart';
import 'leave_management/views/admin_leave_management_view.dart';
import 'student_enrollment_management/views/student_registration_dashboard_view.dart';

class AdminDashboardView extends StatelessWidget {
  final controller = Get.put(AdminDashboardController());

  final List<Widget> pages = [
    AdminAttendancePage(),
    const AdminLeaveManagementView(),
    const StudentRegistrationDashboardView(),
  ];

  final List<IconData> outlinedIcons = const [
    Icons.bar_chart_outlined, // Attendance
    Icons.beach_access_outlined, // Leave
    Icons.school_outlined, // Student Enrollment
  ];

  final List<IconData> filledIcons = const [
    Icons.bar_chart,
    Icons.beach_access,
    Icons.school, // Filled
  ];

  final List<String> labels = const ['Attendance', 'Leave', 'Onboard'];

  AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedTabIndex.value]),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.selectedTabIndex.value,
          height: 70.0,
          items: List.generate(outlinedIcons.length, (index) {
            final isSelected = controller.selectedTabIndex.value == index;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? filledIcons[index] : outlinedIcons[index],
                  size: 24,
                  color: isSelected ? Colors.white : Colors.white54,
                ),
                if (!isSelected)
                  Text(
                    labels[index],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
              ],
            );
          }),
          color: const Color(0xFF00204A),
          buttonBackgroundColor: const Color(0xFF1A73E8),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          onTap: controller.changeTab,
        );
      }),
    );
  }
}

class AdminDashboardController extends GetxController {
  var selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
