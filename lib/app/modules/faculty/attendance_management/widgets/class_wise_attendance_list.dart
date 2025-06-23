import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class ClassWiseAttendanceList extends StatelessWidget {
  const ClassWiseAttendanceList({super.key});

  Color _getComplianceColor(double percentage) {
    if (percentage >= 90) return AppColors.primaryGreen;
    if (percentage >= 75) return AppColors.primaryOrange;
    return AppColors.primaryRed;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyStudentAttendanceController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class-wise Attendance',
          style: TextStyle(fontSize: 12, color: AppColors.darkText),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  style: TextStyle(fontSize: 10),
                  decoration: InputDecoration(
                    hintText: 'Search Class...',
                    hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                    prefixIcon: Icon(Icons.search, size: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                // Handle filter action
              },
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: .5),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.filter_alt_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    const Text('Filter', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // show row,
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
              itemCount: controller.classSnapshots.length,
              itemBuilder: (context, index) {
                final snapshot = controller.classSnapshots[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.className,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkText,
                                  ),
                                ),

                                //Icon and count
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.people_alt_outlined,
                                      size: 16,
                                      color: AppColors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${snapshot.totalStudents.toString()} students',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getComplianceColor(
                                snapshot.attendancePercentage,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${snapshot.attendancePercentage.toStringAsFixed(1)}%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      if (index <
                          controller.classSnapshots.length - 1) // Add a divider
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
}
