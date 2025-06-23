import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_my_attendance_controller.dart';
import '../../../widgets/leave_management_card.dart';
import '../../../widgets/recent_leave_applications_card.dart';

class FacultyMyAttendanceLeaveView extends StatelessWidget {
  const FacultyMyAttendanceLeaveView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyMyAttendanceController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LeaveBalanceCard(),
        const SizedBox(height: 16),
        Obx(() {
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

          final leaveApplication = controller.leaveApplications;

          if (leaveApplication.isEmpty) {
            return const Center(
              child: Text("No leave Applications available."),
            );
          }
          return Container(
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
                ListView.builder(
                  itemCount: leaveApplication.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LeaveRequestCard(request: leaveApplication[index]);
                  },
                ),
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
          );
        }),
      ],
    );
  }
}
