import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/faculty_my_attendance_controller.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.statusPresentGreen;
      case 'Absent':
        return AppColors.statusAbsentRed;
      case 'Late':
        return AppColors.primaryOrange.withValues(alpha: 0.1);
      case 'Leave':
        return AppColors.statusLeaveGrey;
      default:
        return Colors.transparent;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.statusPresentText;
      case 'Absent':
        return AppColors.statusAbsentText;
      case 'Late':
        return AppColors.primaryOrange;
      case 'Leave':
        return AppColors.statusLeaveText;
      default:
        return Colors.transparent;
    }
  }

  IconData _getRecentActivityIcon(String status) {
    switch (status) {
      case 'Present':
        return Icons.check_circle_outline;
      case 'Absent':
        return Icons.cancel_outlined;
      case 'Late':
        return Icons.access_time;
      case 'Leave':
        return Icons.event_busy_outlined;
      default:
        return Icons.info_outline;
    }
  }

  Color _getRecentActivityIconColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.statusPresentText;
      case 'Absent':
        return AppColors.statusAbsentText;
      case 'Late':
        return AppColors.primaryOrange;
      case 'Leave':
        return AppColors.statusLeaveText;
      default:
        return AppColors.greyText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyMyAttendanceController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.6,
          color: const Color(0xFF5F5D5D).withValues(alpha: .1),
        ),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkText,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('View All Recent Activity tapped');
                },
                child: Text(
                  'View All',
                  style: TextStyle(fontSize: 14, color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = controller.recentActivities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _getRecentActivityIcon(activity.status),
                        color: _getRecentActivityIconColor(activity.status),
                        size: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${activity.date.day} ${activity.dayOfWeek} ${activity.date.year}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkText,
                              ),
                            ),
                            Text(
                              activity.title,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            activity.time,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.greyText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (activity.status == 'Unmarked' ||
                              activity.status == 'Absent')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusBgColor(activity.status),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                activity.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatusTextColor(activity.status),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.touch_app_outlined),
                  label: const Text(
                    'Check In/Out',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.event_note),
                  label: const Text(
                    'Apply Leave',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
