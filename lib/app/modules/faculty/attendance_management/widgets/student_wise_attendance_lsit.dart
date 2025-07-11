// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../theme/app_colors.dart';
// import '../controllers/faculty_student_attendance_controller.dart';

// class StudentWiseAttendanceList extends StatelessWidget {
//   const StudentWiseAttendanceList({super.key});

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Present':
//         return Colors.green;
//       case 'Absent':
//         return Colors.red;
//       case 'Late':
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<FacultyStudentAttendanceController>();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Student-wise Attendance',
//           style: TextStyle(fontSize: 12, color: AppColors.darkText),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const TextField(
//                   style: TextStyle(fontSize: 10),
//                   decoration: InputDecoration(
//                     hintText: 'Search Student by name, roll no...',
//                     hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
//                     prefixIcon: Icon(Icons.search, size: 16),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 0,
//                       vertical: 0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 30,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300, width: .5),
//                 ),
//                 child: Row(
//                   children: const [
//                     Icon(
//                       Icons.filter_alt_outlined,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(width: 4),
//                     Text('Filter', style: TextStyle(fontSize: 10)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Obx(() {
          
//           return Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: AppColors.lightGray),
//             ),
//             child: ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.studentList.length,
//               separatorBuilder: (context, index) =>
//                   const Divider(height: 1, thickness: 0.5),
//               itemBuilder: (context, index) {
//                 final student = controller.studentList[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.blue.shade100,
//                         child: Text(
//                           student.name.substring(0, 1).toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.blue,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               student.name,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.darkText,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               student.rollNumber,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(width: 6),
//                       Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _getStatusColor(
//                             student.status,
//                           ).withValues(alpha: .1),
//                         ),
//                         child: Text(
//                           student.status,
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: _getStatusColor(student.status),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       // icon for ...
//                       Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: AppColors.lightGray,
//                         ),
//                         child: PopupMenuButton(
//                           onSelected: (value) {},
//                           itemBuilder: (context) => [
//                             const PopupMenuItem(child: Text('Edit')),
//                             const PopupMenuItem(child: Text('Delete')),
//                           ],
//                           child: const Icon(
//                             Icons.more_vert,
//                             size: 16,
//                             color: AppColors.darkText,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }


// lib/app/modules/faculty_student_attendance/views/student_wise_attendance_list.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class StudentWiseAttendanceList extends StatelessWidget {
  const StudentWiseAttendanceList({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'excused':
        return Colors.blue;
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
                child: TextField(
                  style: const TextStyle(fontSize: 10),
                  decoration: const InputDecoration(
                    hintText: 'Search Student by name, roll no...',
                    hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                    prefixIcon: Icon(Icons.search, size: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                  ),
                  onChanged: (query) {
                    // Implement search functionality in controller
                    // controller.updateStudentSearchQuery(query); // You'd need to add this
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Filter button with dropdown menu
            // Obx(() {
            //   return 
              GestureDetector(
                onTap: () {
                  // Show filter options (e.g., using a custom dialog or bottom sheet)
                  _showFilterDialog(context, controller);
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
              )
              // );
            // }),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.isError.value) {
            return Center(child: Text('Error: ${controller.errorMessage.value}'));
          } else if (controller.studentList.isEmpty) {
            return const Center(child: Text('No students found.'));
          } else {
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
                            ).withOpacity(.1),
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
                            onSelected: (value) {
                              // Handle menu item selection (e.g., 'Edit', 'Delete')
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'Delete',
                                child: Text('Delete'),
                              ),
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
          }
        }),
      ],
    );
  }

  void _showFilterDialog(
      BuildContext context, FacultyStudentAttendanceController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Students',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 20),
            // Department Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Department', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedDepartmentFilter.value ?? controller.departmentFilters.firstOrNull,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Select Department'),
                      onChanged: controller.selectDepartmentFilter,
                      items: controller.departmentFilters
                          .map((department) => DropdownMenuItem(
                                value: department,
                                child: Text(department, style: const TextStyle(fontSize: 14)),
                              ))
                          .toList(),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            // Course Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Course', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedCourseFilter.value ?? controller.courseFilters.firstOrNull,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Select Course'),
                      onChanged: controller.selectCourseFilter,
                      items: controller.courseFilters
                          .map((course) => DropdownMenuItem(
                                value: course,
                                child: Text(course, style: const TextStyle(fontSize: 14)),
                              ))
                          .toList(),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            // Semester Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Semester', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedSemesterFilter.value ?? controller.semesterFilters.firstOrNull,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Select Semester'),
                      onChanged: controller.selectSemesterFilter,
                      items: controller.semesterFilters
                          .map((semester) => DropdownMenuItem(
                                value: semester,
                                child: Text(semester, style: const TextStyle(fontSize: 14)),
                              ))
                          .toList(),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            // Attendance Status Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Attendance Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedAttendanceStatusFilter.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Select Status'),
                      onChanged: controller.selectAttendanceStatusFilter,
                      items: controller.attendanceStatusFilters
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status, style: const TextStyle(fontSize: 14)),
                              ))
                          .toList(),
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.fetchStudentWiseAttendance(); // Apply filters
                  Get.back(); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}