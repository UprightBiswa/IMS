import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../theme/app_colors.dart';
import '../../../../../../admin/attendance_management/views/admin_attendance_page.dart';
import '../../../../controllers/faculty_my_attendance_controller.dart';
import '../../../../widgets/monthly_attendance_card.dart';
import 'faculty_my_attendance_overview_view.dart';
import '../faculty_my_attendance_leave_view.dart';

class FacultyMyAttendanceTab extends StatelessWidget {
  FacultyMyAttendanceTab({super.key});

  final FacultyMyAttendanceController controller = Get.put(
    FacultyMyAttendanceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
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
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primaryBlue,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'My Attendance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
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
                        label: 'Overview',
                        isSelected: controller.selectedSubTab.value == 0,
                        onTap: () => controller.changeSubTab(0),
                      ),

                      TopTabButton(
                        label: 'Leave',
                        isSelected: controller.selectedSubTab.value == 1,
                        onTap: () => controller.changeSubTab(1),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                switch (controller.selectedSubTab.value) {
                  case 0:
                    return const MonthlyAttendanceCard();
                  case 1:
                    return FacultyMyAttendanceLeaveView();
                  default:
                    return Container();
                }
              }),
            ],
          ),
        ),
        Obx(() {
          switch (controller.selectedSubTab.value) {
            case 0:
              return FacultyMyAttendanceOverviewView();
            default:
              return Container();
          }
        }),
      ],
    );
  }
}
