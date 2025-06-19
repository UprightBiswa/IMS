import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class RecentClassesCard extends StatelessWidget {
  const RecentClassesCard({super.key});

  Color _getStatusColor(int count, int total) {
    if (count / total > 0.8) {
      return AppColors.primaryGreen; // More than 80% present
    }
    if (count / total > 0.6) return AppColors.primaryOrange; // 60-80% present
    return AppColors.primaryRed; // Less than 60% present
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyStudentAttendanceController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Classes',
              style: TextStyle(fontSize: 12, color: AppColors.darkText),
            ),
            TextButton(
              onPressed: () {
                print('View All Recent Classes tapped');
              },
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryBlue, fontSize: 13),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recentClasses.length,
              itemBuilder: (context, index) {
                final recentClass = controller.recentClasses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              recentClass.courseName,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(recentClass.date),
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(recentClass.subject),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildAttendanceTag(
                            Icons.check,
                            '${recentClass.presentCount} present',
                            _getStatusColor(
                              recentClass.presentCount,
                              recentClass.totalStudents,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildAttendanceTag(
                            Icons.close,
                            '${recentClass.absentCount} absent',
                            AppColors.primaryRed,
                          ),
                          const SizedBox(width: 8),
                          _buildAttendanceTag(
                            Icons.access_time,
                            '${recentClass.lateCount} late',
                            AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              print('Details for ${recentClass.courseName}');
                              // Navigate to a detailed class attendance view
                            },
                            child: Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (index <
                          controller.recentClasses.length - 1) // Add a divider
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Divider(height: 1, thickness: 0.5),
                        ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAttendanceTag(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
