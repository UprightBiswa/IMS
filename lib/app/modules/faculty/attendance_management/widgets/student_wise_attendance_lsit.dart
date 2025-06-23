import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class StudentWiseAttendanceList extends StatelessWidget {
  const StudentWiseAttendanceList({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyStudentAttendanceController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student-wise Attendance',
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
                    hintText: 'Search Student by name, roll no...',
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
              onTap: () {},
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: .5),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_alt_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text('Filter', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.lightGray),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.studentList.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 0.5),
              itemBuilder: (context, index) {
                final student = controller.studentList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          student.name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              student.rollNumber,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _getStatusColor(
                            student.status,
                          ).withValues(alpha: .1),
                        ),
                        child: Text(
                          student.status,
                          style: TextStyle(
                            fontSize: 11,
                            color: _getStatusColor(student.status),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // icon for ...
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightGray,
                        ),
                        child: PopupMenuButton(
                          onSelected: (value) {},
                          itemBuilder: (context) => [
                            const PopupMenuItem(child: Text('Edit')),
                            const PopupMenuItem(child: Text('Delete')),
                          ],
                          child: const Icon(
                            Icons.more_vert,
                            size: 16,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
