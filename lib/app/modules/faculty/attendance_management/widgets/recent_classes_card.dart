// lib/app/modules/faculty/attendance_management/views/widgets/recent_classes_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';


class RecentClassesCard extends StatelessWidget {
  const RecentClassesCard({super.key});

  Color _getStatusColor(int count, int total) {
    if (count / total > 0.8) return AppColors.primaryGreen; // More than 80% present
    if (count / total > 0.6) return AppColors.primaryOrange; // 60-80% present
    return AppColors.primaryRed; // Less than 60% present
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyStudentAttendanceController>();

    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Classes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
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
            const SizedBox(height: 10),
            Obx(() {
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
                        Text(
                          DateFormat('dd MMM yyyy').format(recentClass.date),
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.greyText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${recentClass.courseName}\n${recentClass.subject}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkText,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print('Details for ${recentClass.courseName}');
                                // Navigate to a detailed class attendance view
                              },
                              child: Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildAttendanceTag(
                              '${recentClass.presentCount} present',
                              _getStatusColor(recentClass.presentCount, recentClass.totalStudents),
                            ),
                            const SizedBox(width: 8),
                            _buildAttendanceTag(
                              '${recentClass.absentCount} absent',
                              AppColors.primaryRed,
                            ),
                            const SizedBox(width: 8),
                            _buildAttendanceTag(
                              '${recentClass.lateCount} late',
                              AppColors.primaryOrange,
                            ),
                            const SizedBox(width: 8),
                            _buildAttendanceTag(
                              '${recentClass.unmarkedCount} unmarked',
                              AppColors.greyText,
                            ),
                          ],
                        ),
                        if (index < controller.recentClasses.length - 1) // Add a divider
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
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}