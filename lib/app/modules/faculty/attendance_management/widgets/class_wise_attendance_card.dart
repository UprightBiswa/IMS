import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class ClassWiseAttendanceCard extends StatelessWidget {
  const ClassWiseAttendanceCard({super.key});

  Color _getComplianceColor(double percentage) {
    if (percentage >= 90) return AppColors.primaryGreen;
    if (percentage >= 75) return AppColors.primaryOrange;
    return AppColors.primaryRed;
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
            Text(
              'Class Attendance Snapshot',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 10),
            // Search and Filter section (Simplified for now)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Students...',
                      prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.filter_list, color: AppColors.primaryBlue),
                  onPressed: () {
                    print('Filter tapped');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.tune, color: AppColors.primaryBlue),
                  onPressed: () {
                    print('Sort tapped');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _buildTableHeader('CLASS')),
                  Expanded(flex: 2, child: _buildTableHeader('ATTENDANCE')),
                  Expanded(flex: 1, child: _buildTableHeader('STUDENTS')),
                  Expanded(flex: 1, child: _buildTableHeader('TOTAL')),
                  Expanded(flex: 1, child: _buildTableHeader('STATUS')),
                ],
              ),
            ),
            const Divider(height: 20, thickness: 1, color: Colors.grey),
            // Class-wise attendance list
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.classSnapshots.length,
                itemBuilder: (context, index) {
                  final snapshot = controller.classSnapshots[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.className,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkText),
                              ),
                              Text(
                                snapshot.section,
                                style: TextStyle(fontSize: 11, color: AppColors.greyText),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${snapshot.attendancePercentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkText),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${snapshot.studentsPresent}',
                            style: TextStyle(fontSize: 13, color: AppColors.greyText),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${snapshot.totalStudents}',
                            style: TextStyle(fontSize: 13, color: AppColors.greyText),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: _getComplianceColor(snapshot.attendancePercentage).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              snapshot.attendancePercentage >= 75 ? 'Good' : 'Low', // Simplified status
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: _getComplianceColor(snapshot.attendancePercentage),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  print('View All Classes tapped');
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: AppColors.primaryBlue, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: AppColors.greyText,
      ),
    );
  }
}