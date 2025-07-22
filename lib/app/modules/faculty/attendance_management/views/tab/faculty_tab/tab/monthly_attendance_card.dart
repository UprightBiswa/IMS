import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../theme/app_colors.dart';
import '../../../../controllers/faculty_my_attendance_controller.dart';

class MonthlyAttendanceCard extends StatelessWidget {
  const MonthlyAttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyMyAttendanceController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          height: 150,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      }

      if (controller.isError.value) {
        return Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            'Error: ${controller.errorMessage.value}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final summary = controller.monthlySummary.value;

      if (summary == null) {
        return const SizedBox(); // Or fallback UI
      }
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FA),
          borderRadius: BorderRadius.circular(8),
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
                  Icons.calendar_today_outlined,
                  color: AppColors.primaryBlue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Monthly Attendance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkText,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withValues(alpha: .9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${summary.complianceMessage.replaceAll('%', '')}%',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.sidebarWhite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 4,
              children: [
                _buildAttendanceItem(
                  summary.present,
                  'Present',
                  AppColors.primaryGreen,
                ),
                _buildAttendanceItem(
                  summary.absent,
                  'Absent',
                  AppColors.primaryRed,
                ),
                _buildAttendanceItem(
                  summary.late,
                  'Late',
                  AppColors.primaryOrange,
                ),
                _buildAttendanceItem(
                  summary.leave,
                  'Leave',
                  AppColors.primaryBlue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Required Attendance: ${summary.requiredPercentage.toInt()}%',
                  style: TextStyle(fontSize: 12, color: AppColors.greyText),
                ),
                Text(
                  '${summary.complianceMessage.replaceAll('%', '')}%', // Just display the percentage part
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        double.parse(
                              summary.complianceMessage.replaceAll('%', ''),
                            ) <
                            summary.requiredPercentage
                        ? AppColors.primaryRed
                        : AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value:
                  double.parse(summary.complianceMessage.replaceAll('%', '')) /
                  100,
              backgroundColor: Colors.grey[200],
              color:
                  double.parse(summary.complianceMessage.replaceAll('%', '')) <
                      summary.requiredPercentage
                  ? AppColors.primaryRed
                  : AppColors.primaryGreen,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 20),
            if (double.parse(summary.complianceMessage.replaceAll('%', '')) <
                summary.requiredPercentage)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.primaryOrange,
                    width: 1.15,
                  ),
                ),
                child: Text(
                  'Your attendance is below ${summary.requiredPercentage.toInt()}% this month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildAttendanceItem(int count, String label, Color color) {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$count',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.greyText,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
