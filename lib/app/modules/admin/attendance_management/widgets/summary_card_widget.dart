import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_attendance_controller.dart';
import '../models/summary_card_model.dart';

class SummaryCardWidget extends StatelessWidget {
  final SummaryCardModel data;

  const SummaryCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.primaryBlue.withValues(alpha: .1),
                ),
                child: Icon(data.icon, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(data.value, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (data.subtitle.isNotEmpty)
            Text(
              data.subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black45),
            ),
          if (data.progressValue != null) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: data.progressValue,
              backgroundColor: Colors.grey.shade200,
              color: AppColors.primaryBlue,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ],
      ),
    );
  }
}

class StudentDashboardTopSection extends StatelessWidget {
  StudentDashboardTopSection({super.key});
  final AttendanceDashboardController controller = Get.put(
    AttendanceDashboardController(),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedTab.value) {
        case 0:
          return _buildStudentDashboardTopSection();
        case 1:
          return _buildFacultyDashboardTopSection();
        case 2:
          return _buildStaffDashboardTopSection();
        default:
          return SizedBox.shrink();
      }
    });
  }

  Widget _buildStudentDashboardTopSection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.studentSummaryCards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) =>
          SummaryCardWidget(data: controller.studentSummaryCards[index]),
    );
  }

  Widget _buildFacultyDashboardTopSection() {
    // Summary Cards Grid
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.facultySummaryCards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) =>
          SummaryCardWidget(data: controller.facultySummaryCards[index]),
    );
  }

  Widget _buildStaffDashboardTopSection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.staffSummaryCards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) =>
          SummaryCardWidget(data: controller.staffSummaryCards[index]),
    );
  }
}
