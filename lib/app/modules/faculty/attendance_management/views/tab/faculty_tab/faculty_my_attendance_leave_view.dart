import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_my_attendance_controller.dart';
import '../../../widgets/leave_management_card.dart';
import '../../../widgets/recent_leave_applications_card.dart';

class FacultyMyAttendanceLeaveView extends StatelessWidget {
  FacultyMyAttendanceLeaveView({super.key});

  final FacultyMyAttendanceController controller =
      Get.find<FacultyMyAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LeaveBalanceCard(),
        const SizedBox(height: 16),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFF3F4F5)),
                ),
                child: Text(
                  'Recent Leave Applications',
                  style: TextStyle(fontSize: 16, color: AppColors.darkText),
                ),
              ),

              const SizedBox(height: 16),
              Obx(() {
                return Column(
                  children: controller.leaveHistory.isEmpty
                      ? [const Text('No leave history available.')]
                      : controller.leaveHistory
                            .map(
                              (request) => LeaveRequestCard(request: request),
                            )
                            .toList(),
                );

              }),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFF3F4F5)),
                ),
                child: Text(
                  'View All Applicaions',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.darkText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveSubTabButton({
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
