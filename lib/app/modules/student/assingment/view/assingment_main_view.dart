import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/assingment_tab_controller.dart';
import 'attendance_calendar_screen.dart';
import 'attendance_leave_request_screen.dart';
import 'attendance_overview_screen.dart';

class AssignmentsMainView extends StatelessWidget {
  AssignmentsMainView({super.key});
  final AssignmentsTabController controller = Get.put(AssignmentsTabController());

  final List<Widget> pages = const [
    AttendanceOverviewTab(),
    AttendanceCalendarTab(),
    AttendanceLeaveTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Attendance Management'),
      body: Obx(() {
        return pages[controller.selectedTabIndex.value];
      }),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3), // subtle shadow on top
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSegmentButton(
                      context,
                      label: 'Overview',
                      index: 0,
                      controller: controller,
                    ),
                    _buildSegmentButton(
                      context,
                      label: 'Calendar',
                      index: 1,
                      controller: controller,
                    ),
                    _buildSegmentButton(
                      context,
                      label: 'Leave',
                      index: 2,
                      controller: controller,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(
    BuildContext context, {
    required String label,
    required int index,
    required AssignmentsTabController controller,
  }) {
    final bool isSelected = controller.selectedTabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: Colors.transparent),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryBlue : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
